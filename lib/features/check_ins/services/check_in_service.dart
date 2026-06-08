import 'package:flutter/material.dart';

import '../models/check_in_model.dart';
import '../check_in_activity_connector.dart';
import '../check_in_goal_connector.dart';
import '../check_in_notifications_connector.dart';
import '../check_in_space_connector.dart';

class CheckInService {
  CheckInService._();

  static final CheckInService instance = CheckInService._();

  final List<CheckInModel> _checkIns = [];

  List<CheckInModel> get allCheckIns {
    _ensureDefaultsLoaded();
    return List.unmodifiable(_checkIns);
  }

  List<CheckInModel> get activeCheckIns {
    _ensureDefaultsLoaded();
    return _checkIns.where((item) => item.active).toList();
  }

  List<CheckInModel> get dueCheckIns {
    _ensureDefaultsLoaded();
    return _checkIns
        .where((item) => item.active && _isDue(item) && !item.completed)
        .toList();
  }

  List<CheckInModel> get completedTodayCheckIns {
    _ensureDefaultsLoaded();
    return _checkIns
        .where(
          (item) =>
              item.active &&
              item.completed &&
              item.completedAt != null &&
              _isSameDay(item.completedAt!, DateTime.now()),
        )
        .toList();
  }

  List<CheckInModel> get dashboardCheckIns {
    _ensureDefaultsLoaded();
    return _checkIns
        .where(
          (item) =>
              item.active &&
              item.appearsOnDashboard &&
              _isDue(item),
        )
        .toList();
  }

  List<CheckInModel> get beautyCheckIns {
    _ensureDefaultsLoaded();
    return _checkIns
        .where((item) => item.active && item.appearsInBeauty)
        .toList();
  }

  List<CheckInModel> get wellnessCheckIns {
    _ensureDefaultsLoaded();
    return _checkIns
        .where((item) => item.active && item.appearsInWellness)
        .toList();
  }

  List<CheckInModel> get goalLinkedCheckIns {
    _ensureDefaultsLoaded();
    return _checkIns
        .where((item) => item.active && item.linkedToGoal)
        .toList();
  }

  int get dashboardDueCount => dashboardCheckIns.length;

  int get dashboardCompletedCount =>
      dashboardCheckIns.where((item) => item.completed).length;

  double get dashboardProgress {
    if (dashboardDueCount == 0) return 0;
    return dashboardCompletedCount / dashboardDueCount;
  }

  List<CheckInModel> byFrequency(CheckInFrequency frequency) {
    _ensureDefaultsLoaded();
    return _checkIns
        .where((item) => item.active && item.frequency == frequency)
        .toList();
  }

  List<CheckInModel> byCategory(CheckInCategory category) {
    _ensureDefaultsLoaded();
    return _checkIns
        .where((item) => item.active && item.category == category)
        .toList();
  }

  CheckInModel? findById(String id) {
    _ensureDefaultsLoaded();

    try {
      return _checkIns.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  void addCheckIn(CheckInModel checkIn) {
    final exists = _checkIns.any((item) => item.id == checkIn.id);
    if (exists) return;

    _checkIns.add(checkIn);
  }

  void updateCheckIn(CheckInModel updatedCheckIn) {
    final index =
        _checkIns.indexWhere((item) => item.id == updatedCheckIn.id);

    if (index == -1) {
      _checkIns.add(updatedCheckIn);
      return;
    }

    _checkIns[index] = updatedCheckIn;
  }

  void deleteCheckIn(String id) {
    _checkIns.removeWhere((item) => item.id == id);
  }

  void archiveCheckIn(String id) {
    final item = findById(id);
    if (item == null) return;

    updateCheckIn(item.copyWith(active: false));
  }

  void completeCheckIn(String id) {
    final item = findById(id);
    if (item == null) return;

    final completedItem = item.copyWith(
      completed: true,
      completedAt: DateTime.now(),
    );

    updateCheckIn(completedItem);

    _logToRecentActivity(completedItem);
    _syncToGoal(completedItem);
    _syncToSpaces(completedItem);
    _clearReminder(completedItem);
  }

  void undoCompleteCheckIn(String id) {
    final item = findById(id);
    if (item == null) return;

    updateCheckIn(
      item.copyWith(
        completed: false,
        completedAt: null,
      ),
    );
  }

  void createMissedRemindersForDueItems() {
    for (final item in dueCheckIns) {
      if (!item.reminderEnabled) continue;

      CheckInNotificationsConnector.instance.createMissedReminder(
        checkInId: item.id,
        title: item.title,
        frequency: _frequencyLabel(item.frequency),
      );
    }
  }

  void resetDailyCheckIns() {
    _resetFrequency(CheckInFrequency.daily);
  }

  void resetWeeklyCheckIns() {
    _resetFrequency(CheckInFrequency.weekly);
  }

  void resetMonthlyCheckIns() {
    _resetFrequency(CheckInFrequency.monthly);
  }

  void resetYearlyCheckIns() {
    _resetFrequency(CheckInFrequency.yearly);
  }

  void resetAllDueCheckIns() {
    for (final item in _checkIns) {
      if (_isDue(item)) {
        updateCheckIn(
          item.copyWith(
            completed: false,
            completedAt: null,
          ),
        );
      }
    }
  }

  void _resetFrequency(CheckInFrequency frequency) {
    for (final item in _checkIns) {
      if (item.frequency == frequency) {
        updateCheckIn(
          item.copyWith(
            completed: false,
            completedAt: null,
          ),
        );
      }
    }
  }

  bool _isDue(CheckInModel item) {
    final now = DateTime.now();

    if (item.frequency == CheckInFrequency.daily) {
      return true;
    }

    if (item.frequency == CheckInFrequency.weekly) {
      return now.weekday == DateTime.sunday;
    }

    if (item.frequency == CheckInFrequency.monthly) {
      final tomorrow = now.add(const Duration(days: 1));
      final bool firstDay = now.day == 1;
      final bool lastDay = tomorrow.month != now.month;

      return firstDay || lastDay;
    }

    if (item.frequency == CheckInFrequency.yearly) {
      final bool janFirst = now.month == 1 && now.day == 1;
      final bool decThirtyFirst = now.month == 12 && now.day == 31;

      return janFirst || decThirtyFirst;
    }

    return false;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _frequencyLabel(CheckInFrequency frequency) {
    switch (frequency) {
      case CheckInFrequency.daily:
        return 'daily';
      case CheckInFrequency.weekly:
        return 'weekly';
      case CheckInFrequency.monthly:
        return 'monthly';
      case CheckInFrequency.yearly:
        return 'yearly';
    }
  }

  String _categoryLabel(CheckInCategory category) {
    switch (category) {
      case CheckInCategory.beauty:
        return 'Beauty';
      case CheckInCategory.wellness:
        return 'Wellness';
      case CheckInCategory.health:
        return 'Health';
      case CheckInCategory.spiritual:
        return 'Spiritual';
      case CheckInCategory.family:
        return 'Family';
      case CheckInCategory.school:
        return 'School';
      case CheckInCategory.work:
        return 'Work';
      case CheckInCategory.business:
        return 'Business';
      case CheckInCategory.home:
        return 'Home';
      case CheckInCategory.custom:
        return 'Custom';
    }
  }

  void _ensureDefaultsLoaded() {
    if (_checkIns.isNotEmpty) return;
    loadDefaultCheckIns();
  }

  void loadDefaultCheckIns() {
    if (_checkIns.isNotEmpty) return;

    final now = DateTime.now();

    _checkIns.addAll([
      CheckInModel(
        id: 'hydration_daily',
        title: 'Drink Water',
        description:
            'Hydration check-in shared with Wellness, Beauty, Goals, and Dashboard.',
        icon: Icons.water_drop_outlined,
        frequency: CheckInFrequency.daily,
        category: CheckInCategory.wellness,
        linkedToGoal: true,
        goalId: 'hydration_goal',
        appearsOnDashboard: true,
        appearsInBeauty: true,
        appearsInWellness: true,
        appearsInGoals: true,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 9, minute: 0),
        createdAt: now,
      ),
      CheckInModel(
        id: 'beauty_skincare_daily',
        title: 'Skincare Routine',
        description: 'Cleanse, moisturize, and protect your face.',
        icon: Icons.spa_outlined,
        frequency: CheckInFrequency.daily,
        category: CheckInCategory.beauty,
        linkedToGoal: false,
        goalId: null,
        appearsOnDashboard: true,
        appearsInBeauty: true,
        appearsInWellness: false,
        appearsInGoals: false,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 20, minute: 0),
        createdAt: now,
      ),
      CheckInModel(
        id: 'beauty_body_moisture_daily',
        title: 'Body Moisture',
        description: 'Lotion, oil, or body butter.',
        icon: Icons.auto_awesome_outlined,
        frequency: CheckInFrequency.daily,
        category: CheckInCategory.beauty,
        linkedToGoal: false,
        goalId: null,
        appearsOnDashboard: true,
        appearsInBeauty: true,
        appearsInWellness: false,
        appearsInGoals: false,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 21, minute: 0),
        createdAt: now,
      ),
      CheckInModel(
        id: 'beauty_hair_protection_daily',
        title: 'Hair Protection',
        description: 'Wrap, bonnet, scarf, or reset before sleep.',
        icon: Icons.face_retouching_natural_outlined,
        frequency: CheckInFrequency.daily,
        category: CheckInCategory.beauty,
        linkedToGoal: false,
        goalId: null,
        appearsOnDashboard: true,
        appearsInBeauty: true,
        appearsInWellness: false,
        appearsInGoals: false,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 22, minute: 0),
        createdAt: now,
      ),
      CheckInModel(
        id: 'beauty_ears_weekly',
        title: 'Clean Inside Ears',
        description: 'Gentle inside-ear cleaning reminder.',
        icon: Icons.hearing_outlined,
        frequency: CheckInFrequency.weekly,
        category: CheckInCategory.beauty,
        linkedToGoal: false,
        goalId: null,
        appearsOnDashboard: true,
        appearsInBeauty: true,
        appearsInWellness: false,
        appearsInGoals: false,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 10, minute: 0),
        createdAt: now,
      ),
      CheckInModel(
        id: 'beauty_deep_condition_weekly',
        title: 'Deep Condition',
        description: 'Weekly hair moisture and softness check-in.',
        icon: Icons.shower_outlined,
        frequency: CheckInFrequency.weekly,
        category: CheckInCategory.beauty,
        linkedToGoal: false,
        goalId: null,
        appearsOnDashboard: true,
        appearsInBeauty: true,
        appearsInWellness: false,
        appearsInGoals: false,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 11, minute: 0),
        createdAt: now,
      ),
      CheckInModel(
        id: 'beauty_exfoliate_weekly',
        title: 'Exfoliate',
        description: 'Body or face exfoliation reminder.',
        icon: Icons.blur_on_outlined,
        frequency: CheckInFrequency.weekly,
        category: CheckInCategory.beauty,
        linkedToGoal: false,
        goalId: null,
        appearsOnDashboard: false,
        appearsInBeauty: true,
        appearsInWellness: false,
        appearsInGoals: false,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 19, minute: 0),
        createdAt: now,
      ),
      CheckInModel(
        id: 'beauty_shave_monthly',
        title: 'Shave / Groom',
        description: 'Twice monthly by default. Timing can change later.',
        icon: Icons.content_cut_rounded,
        frequency: CheckInFrequency.monthly,
        category: CheckInCategory.beauty,
        linkedToGoal: false,
        goalId: null,
        appearsOnDashboard: true,
        appearsInBeauty: true,
        appearsInWellness: false,
        appearsInGoals: false,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 18, minute: 0),
        createdAt: now,
      ),
      CheckInModel(
        id: 'beauty_tools_monthly',
        title: 'Clean Beauty Tools',
        description: 'Brushes, combs, razors, nail tools, and makeup tools.',
        icon: Icons.cleaning_services_outlined,
        frequency: CheckInFrequency.monthly,
        category: CheckInCategory.beauty,
        linkedToGoal: false,
        goalId: null,
        appearsOnDashboard: false,
        appearsInBeauty: true,
        appearsInWellness: false,
        appearsInGoals: false,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 12, minute: 0),
        createdAt: now,
      ),
      CheckInModel(
        id: 'beauty_yearly_reset',
        title: 'Beauty Reset',
        description:
            'Review beauty goals, routines, photos, products, and maintenance plans.',
        icon: Icons.workspace_premium_outlined,
        frequency: CheckInFrequency.yearly,
        category: CheckInCategory.beauty,
        linkedToGoal: true,
        goalId: 'beauty_yearly_goal',
        appearsOnDashboard: true,
        appearsInBeauty: true,
        appearsInWellness: false,
        appearsInGoals: true,
        appearsInActivity: true,
        reminderEnabled: true,
        reminderTime: const TimeOfDay(hour: 10, minute: 0),
        createdAt: now,
      ),
    ]);
  }

  void _logToRecentActivity(CheckInModel item) {
    if (!item.appearsInActivity) return;

    CheckInActivityConnector.instance.logCheckInCompleted(
      checkInId: item.id,
      title: item.title,
      category: _categoryLabel(item.category),
    );
  }

  void _syncToGoal(CheckInModel item) {
    if (!item.linkedToGoal || item.goalId == null) return;

    CheckInGoalConnector.instance.updateGoalFromCheckIn(
      goalId: item.goalId!,
      checkInId: item.id,
      title: item.title,
    );
  }

  void _syncToSpaces(CheckInModel item) {
    CheckInSpaceConnector.instance.syncToSpaces(
      checkInId: item.id,
      dashboard: item.appearsOnDashboard,
      beauty: item.appearsInBeauty,
      wellness: item.appearsInWellness,
      goals: item.appearsInGoals,
    );
  }

  void _clearReminder(CheckInModel item) {
    CheckInNotificationsConnector.instance.removeReminderForCheckIn(item.id);
  }
}
