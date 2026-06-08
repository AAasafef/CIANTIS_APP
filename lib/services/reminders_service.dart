import 'package:flutter/material.dart';

import '../models/reminder_item.dart';

import 'activity_log_service.dart';

class RemindersService extends ChangeNotifier {
  static final RemindersService instance =
      RemindersService._internal();

  RemindersService._internal();

  final List<ReminderItem> _reminders = [];

  List<ReminderItem> get reminders {
    final copy = _reminders.where((reminder) {
      return !reminder.isDeleted;
    }).toList();

    copy.sort((a, b) {
      return a.remindAt.compareTo(
        b.remindAt,
      );
    });

    return copy;
  }

  List<ReminderItem> get deletedReminders {
    final copy = _reminders.where((reminder) {
      return reminder.isDeleted;
    }).toList();

    copy.sort((a, b) {
      final aDeleted =
          a.deletedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

      final bDeleted =
          b.deletedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

      return bDeleted.compareTo(aDeleted);
    });

    return copy;
  }

  Future<void> createReminder({
    required String title,
    String notes = '',
    required String spaceId,
    required String spaceName,
    required DateTime remindAt,
    String? linkedItemId,
  }) async {
    final now = DateTime.now();

    final reminder = ReminderItem(
      id: now.microsecondsSinceEpoch.toString(),
      title: title,
      notes: notes,
      spaceId: spaceId,
      spaceName: spaceName,
      linkedItemId: linkedItemId,
      createdAt: now,
      remindAt: remindAt,
    );

    _reminders.insert(0, reminder);

    await ActivityLogService.instance.addActivity(
      title: 'Reminder Created',
      description: title,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: 'created',
    );

    notifyListeners();
  }

  Future<void> completeReminder(
    String id,
  ) async {
    final index = _reminders.indexWhere(
      (reminder) => reminder.id == id,
    );

    if (index == -1) return;

    final reminder = _reminders[index];

    _reminders[index] = reminder.copyWith(
      completedAt: DateTime.now(),
    );

    await ActivityLogService.instance.addActivity(
      title: 'Reminder Completed',
      description: reminder.title,
      spaceId: reminder.spaceId,
      spaceName: reminder.spaceName,
      actionType: 'completed',
    );

    notifyListeners();
  }

  Future<void> reopenReminder(
    String id,
  ) async {
    final index = _reminders.indexWhere(
      (reminder) => reminder.id == id,
    );

    if (index == -1) return;

    final reminder = _reminders[index];

    _reminders[index] = reminder.copyWith(
      clearCompletedAt: true,
    );

    notifyListeners();
  }

  Future<void> deleteReminder(
    String id,
  ) async {
    final index = _reminders.indexWhere(
      (reminder) => reminder.id == id,
    );

    if (index == -1) return;

    final reminder = _reminders[index];

    _reminders[index] = reminder.copyWith(
      deletedAt: DateTime.now(),
    );

    await ActivityLogService.instance.addActivity(
      title: 'Reminder Deleted',
      description: reminder.title,
      spaceId: reminder.spaceId,
      spaceName: reminder.spaceName,
      actionType: 'deleted',
    );

    notifyListeners();
  }

  Future<void> restoreReminder(
    String id,
  ) async {
    final index = _reminders.indexWhere(
      (reminder) => reminder.id == id,
    );

    if (index == -1) return;

    final reminder = _reminders[index];

    _reminders[index] = reminder.copyWith(
      clearDeletedAt: true,
    );

    notifyListeners();
  }

  Future<void> permanentlyDeleteReminder(
    String id,
  ) async {
    _reminders.removeWhere(
      (reminder) => reminder.id == id,
    );

    notifyListeners();
  }

  Future<void> emptyTrash() async {
    _reminders.removeWhere(
      (reminder) => reminder.isDeleted,
    );

    notifyListeners();
  }

  List<ReminderItem> remindersForSpace(
    String spaceId,
  ) {
    return reminders.where((reminder) {
      return reminder.spaceId == spaceId;
    }).toList();
  }
}