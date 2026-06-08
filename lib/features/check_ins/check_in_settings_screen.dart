import 'package:flutter/material.dart';

import 'models/check_in_model.dart';
import 'services/check_in_service.dart';

class CheckInSettingsScreen extends StatefulWidget {
  const CheckInSettingsScreen({
    super.key,
  });

  @override
  State<CheckInSettingsScreen> createState() =>
      _CheckInSettingsScreenState();
}

class _CheckInSettingsScreenState
    extends State<CheckInSettingsScreen> {
  final CheckInService service = CheckInService.instance;

  String selectedTab = 'Daily';

  final List<String> tabs = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
    'Custom',
  ];

  @override
  void initState() {
    super.initState();
    service.loadDefaultCheckIns();
  }

  List<CheckInModel> get visibleCheckIns {
    if (selectedTab == 'Daily') {
      return service.byFrequency(CheckInFrequency.daily);
    }

    if (selectedTab == 'Weekly') {
      return service.byFrequency(CheckInFrequency.weekly);
    }

    if (selectedTab == 'Monthly') {
      return service.byFrequency(CheckInFrequency.monthly);
    }

    if (selectedTab == 'Yearly') {
      return service.byFrequency(CheckInFrequency.yearly);
    }

    return service
        .byCategory(CheckInCategory.custom);
  }

  void _toggleActive(CheckInModel item) {
    service.updateCheckIn(
      item.copyWith(
        active: !item.active,
      ),
    );

    setState(() {});
  }

  void _toggleDashboard(CheckInModel item) {
    service.updateCheckIn(
      item.copyWith(
        appearsOnDashboard:
            !item.appearsOnDashboard,
      ),
    );

    setState(() {});
  }

  void _toggleBeauty(CheckInModel item) {
    service.updateCheckIn(
      item.copyWith(
        appearsInBeauty: !item.appearsInBeauty,
      ),
    );

    setState(() {});
  }

  void _toggleWellness(CheckInModel item) {
    service.updateCheckIn(
      item.copyWith(
        appearsInWellness:
            !item.appearsInWellness,
      ),
    );

    setState(() {});
  }

  void _toggleGoals(CheckInModel item) {
    service.updateCheckIn(
      item.copyWith(
        appearsInGoals: !item.appearsInGoals,
      ),
    );

    setState(() {});
  }

  void _toggleActivity(CheckInModel item) {
    service.updateCheckIn(
      item.copyWith(
        appearsInActivity:
            !item.appearsInActivity,
      ),
    );

    setState(() {});
  }

  void _toggleReminder(CheckInModel item) {
    service.updateCheckIn(
      item.copyWith(
        reminderEnabled:
            !item.reminderEnabled,
      ),
    );

    setState(() {});
  }

  void _openAddCustomCheckIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const _AddCustomCheckInScreen(),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  void _openResetSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return const _ResetSettingsSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _CiantisColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                20,
                24,
                12,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _SoftIconButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () =>
                            Navigator.pop(context),
                      ),
                      const Spacer(),
                      _SoftIconButton(
                        icon: Icons.restart_alt_rounded,
                        onTap: _openResetSettings,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Check-In Settings',
                    style: TextStyle(
                      color: _CiantisColors.ink,
                      fontSize: 38,
                      fontWeight: FontWeight.w300,
                      height: .96,
                      letterSpacing: -1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'CONTROL WHAT SHOWS • WHERE IT SHOWS • WHEN IT RETURNS',
                    style: TextStyle(
                      color: _CiantisColors.muted,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.4,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SystemNoticeCard(
                    onTap: _openResetSettings,
                  ),
                  const SizedBox(height: 18),
                  _TabBar(
                    tabs: tabs,
                    selectedTab: selectedTab,
                    onChanged: (value) {
                      setState(() {
                        selectedTab = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  24,
                  4,
                  24,
                  120,
                ),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedTab,
                          style: const TextStyle(
                            color: _CiantisColors.ink,
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -.3,
                          ),
                        ),
                      ),
                      Text(
                        '${visibleCheckIns.length} items',
                        style: const TextStyle(
                          color: _CiantisColors.muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (visibleCheckIns.isEmpty)
                    const _EmptySettingsCard(),
                  ...visibleCheckIns.map(
                    (item) => _CheckInSettingsTile(
                      item: item,
                      onActiveToggle: () =>
                          _toggleActive(item),
                      onDashboardToggle: () =>
                          _toggleDashboard(item),
                      onBeautyToggle: () =>
                          _toggleBeauty(item),
                      onWellnessToggle: () =>
                          _toggleWellness(item),
                      onGoalsToggle: () =>
                          _toggleGoals(item),
                      onActivityToggle: () =>
                          _toggleActivity(item),
                      onReminderToggle: () =>
                          _toggleReminder(item),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _AddCustomButton(
                    onTap: _openAddCustomCheckIn,
                  ),
                  const SizedBox(height: 14),
                  const _ReminderInfoCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CiantisColors {
  static const cream = Color(0xFFF4EFE8);
  static const card = Color(0xFFFBF8F4);
  static const ink = Color(0xFF241D18);
  static const muted = Color(0xFF8B7D72);
  static const softBorder = Color(0xFFE2D8CD);
  static const taupe = Color(0xFF8B6F55);
  static const gold = Color(0xFFC6A06B);
  static const softTaupe = Color(0xFFF0E6DB);
  static const deepBrown = Color(0xFF3A2D25);
  static const complete = Color(0xFF7D9B64);
  static const alert = Color(0xFFB9795F);
}

class _SoftIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SoftIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          color:
              _CiantisColors.card.withOpacity(.92),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _CiantisColors.softBorder,
            width: .7,
          ),
        ),
        child: Icon(
          icon,
          color: _CiantisColors.ink,
          size: 21,
        ),
      ),
    );
  }
}

class _SystemNoticeCard extends StatelessWidget {
  final VoidCallback onTap;

  const _SystemNoticeCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _CiantisColors.card
              .withOpacity(.90),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _CiantisColors.softBorder,
            width: .75,
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.tune_rounded,
              color: _CiantisColors.taupe,
              size: 22,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Daily shows every day. Weekly, monthly, and yearly only return when due. Completed items can reset later based on these settings.',
                style: TextStyle(
                  color: _CiantisColors.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final List<String> tabs;
  final String selectedTab;
  final ValueChanged<String> onChanged;

  const _TabBar({
    required this.tabs,
    required this.selectedTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: tabs.map((tab) {
          final bool active = tab == selectedTab;

          return GestureDetector(
            onTap: () => onChanged(tab),
            child: Container(
              margin: const EdgeInsets.only(right: 9),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: active
                    ? _CiantisColors.deepBrown
                    : _CiantisColors.card
                        .withOpacity(.88),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: active
                      ? _CiantisColors.deepBrown
                      : _CiantisColors.softBorder,
                  width: .75,
                ),
              ),
              child: Text(
                tab,
                style: TextStyle(
                  color: active
                      ? _CiantisColors.card
                      : _CiantisColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  letterSpacing: .2,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CheckInSettingsTile extends StatelessWidget {
  final CheckInModel item;
  final VoidCallback onActiveToggle;
  final VoidCallback onDashboardToggle;
  final VoidCallback onBeautyToggle;
  final VoidCallback onWellnessToggle;
  final VoidCallback onGoalsToggle;
  final VoidCallback onActivityToggle;
  final VoidCallback onReminderToggle;

  const _CheckInSettingsTile({
    required this.item,
    required this.onActiveToggle,
    required this.onDashboardToggle,
    required this.onBeautyToggle,
    required this.onWellnessToggle,
    required this.onGoalsToggle,
    required this.onActivityToggle,
    required this.onReminderToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _CiantisColors.card.withOpacity(.88),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: item.active
              ? _CiantisColors.softBorder
              : _CiantisColors.alert.withOpacity(.35),
          width: .75,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 4,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            14,
            0,
            14,
            16,
          ),
          iconColor: _CiantisColors.taupe,
          collapsedIconColor: _CiantisColors.muted,
          leading: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: _CiantisColors.softTaupe,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              item.icon,
              color: _CiantisColors.taupe,
              size: 21,
            ),
          ),
          title: Text(
            item.title,
            style: const TextStyle(
              color: _CiantisColors.ink,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: Text(
            '${_frequencyLabel(item.frequency)} • ${_categoryLabel(item.category)}',
            style: const TextStyle(
              color: _CiantisColors.muted,
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: Switch.adaptive(
            value: item.active,
            onChanged: (_) => onActiveToggle(),
            activeColor: _CiantisColors.complete,
          ),
          children: [
            _DescriptionText(
              text: item.description,
            ),
            const SizedBox(height: 12),
            _VisibilityGrid(
              item: item,
              onDashboardToggle: onDashboardToggle,
              onBeautyToggle: onBeautyToggle,
              onWellnessToggle: onWellnessToggle,
              onGoalsToggle: onGoalsToggle,
              onActivityToggle: onActivityToggle,
            ),
            const SizedBox(height: 12),
            _ReminderRow(
              item: item,
              onReminderToggle: onReminderToggle,
            ),
          ],
        ),
      ),
    );
  }

  String _frequencyLabel(
    CheckInFrequency frequency,
  ) {
    switch (frequency) {
      case CheckInFrequency.daily:
        return 'Daily';
      case CheckInFrequency.weekly:
        return 'Weekly';
      case CheckInFrequency.monthly:
        return 'Monthly';
      case CheckInFrequency.yearly:
        return 'Yearly';
    }
  }

  String _categoryLabel(
    CheckInCategory category,
  ) {
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
}

class _DescriptionText extends StatelessWidget {
  final String text;

  const _DescriptionText({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _CiantisColors.muted,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        height: 1.45,
      ),
    );
  }
}

class _VisibilityGrid extends StatelessWidget {
  final CheckInModel item;
  final VoidCallback onDashboardToggle;
  final VoidCallback onBeautyToggle;
  final VoidCallback onWellnessToggle;
  final VoidCallback onGoalsToggle;
  final VoidCallback onActivityToggle;

  const _VisibilityGrid({
    required this.item,
    required this.onDashboardToggle,
    required this.onBeautyToggle,
    required this.onWellnessToggle,
    required this.onGoalsToggle,
    required this.onActivityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MiniToggleChip(
                label: 'Dashboard',
                active: item.appearsOnDashboard,
                onTap: onDashboardToggle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _MiniToggleChip(
                label: 'Beauty',
                active: item.appearsInBeauty,
                onTap: onBeautyToggle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _MiniToggleChip(
                label: 'Wellness',
                active: item.appearsInWellness,
                onTap: onWellnessToggle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _MiniToggleChip(
                label: 'Goals',
                active: item.appearsInGoals,
                onTap: onGoalsToggle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _MiniToggleChip(
                label: 'Activity',
                active: item.appearsInActivity,
                onTap: onActivityToggle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MiniToggleChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _MiniToggleChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = active
        ? _CiantisColors.complete
        : _CiantisColors.muted;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active
              ? _CiantisColors.complete
                  .withOpacity(.10)
              : _CiantisColors.softTaupe
                  .withOpacity(.62),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color.withOpacity(.45),
            width: .75,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  final CheckInModel item;
  final VoidCallback onReminderToggle;

  const _ReminderRow({
    required this.item,
    required this.onReminderToggle,
  });

  @override
  Widget build(BuildContext context) {
    final TimeOfDay? time = item.reminderTime;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _CiantisColors.softTaupe
            .withOpacity(.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _CiantisColors.softBorder,
          width: .7,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.notifications_none_rounded,
            color: _CiantisColors.taupe,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              time == null
                  ? 'Reminder time not set'
                  : 'Reminder ${time.format(context)}',
              style: const TextStyle(
                color: _CiantisColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Switch.adaptive(
            value: item.reminderEnabled,
            onChanged: (_) => onReminderToggle(),
            activeColor: _CiantisColors.complete,
          ),
        ],
      ),
    );
  }
}

class _AddCustomButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddCustomButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _CiantisColors.deepBrown,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Text(
          '+ Add Custom Check-In',
          style: TextStyle(
            color: _CiantisColors.card,
            fontSize: 13,
            fontWeight: FontWeight.w300,
            letterSpacing: .4,
          ),
        ),
      ),
    );
  }
}

class _ReminderInfoCard extends StatelessWidget {
  const _ReminderInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: _CiantisColors.softTaupe
            .withOpacity(.62),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _CiantisColors.softBorder,
          width: .75,
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: _CiantisColors.taupe,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Later, missed check-ins will create reminders and completed check-ins will appear in Recent Activity automatically.',
              style: TextStyle(
                color: _CiantisColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.w300,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySettingsCard extends StatelessWidget {
  const _EmptySettingsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _CiantisColors.card.withOpacity(.88),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _CiantisColors.softBorder,
          width: .75,
        ),
      ),
      child: const Text(
        'No check-ins here yet. Add a custom check-in when you are ready.',
        style: TextStyle(
          color: _CiantisColors.muted,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          height: 1.4,
        ),
      ),
    );
  }
}

class _ResetSettingsSheet extends StatelessWidget {
  const _ResetSettingsSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        24,
        14,
        24,
        34,
      ),
      decoration: const BoxDecoration(
        color: _CiantisColors.cream,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 46,
                decoration: BoxDecoration(
                  color: _CiantisColors.softBorder,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Reset Schedule',
              style: TextStyle(
                color: _CiantisColors.ink,
                fontSize: 26,
                fontWeight: FontWeight.w300,
                letterSpacing: -.4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is the future settings area for choosing weekly reset day, monthly reset day, yearly reset dates, and reminder timing.',
              style: TextStyle(
                color: _CiantisColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w300,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            const _SettingsRow(
              label: 'Weekly reset',
              value: 'Sunday',
            ),
            const _SettingsRow(
              label: 'Monthly reset',
              value: '1st or last day',
            ),
            const _SettingsRow(
              label: 'Yearly reset',
              value: 'Jan 1 / Dec 31',
            ),
            const _SettingsRow(
              label: 'Missed reminders',
              value: 'Reminder Center',
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String label;
  final String value;

  const _SettingsRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _CiantisColors.card
            .withOpacity(.86),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: _CiantisColors.softBorder,
          width: .75,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _CiantisColors.ink,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: _CiantisColors.taupe,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddCustomCheckInScreen extends StatefulWidget {
  const _AddCustomCheckInScreen();

  @override
  State<_AddCustomCheckInScreen> createState() =>
      _AddCustomCheckInScreenState();
}

class _AddCustomCheckInScreenState
    extends State<_AddCustomCheckInScreen> {
  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  CheckInFrequency frequency =
      CheckInFrequency.daily;

  CheckInCategory category =
      CheckInCategory.custom;

  bool appearsOnDashboard = true;
  bool appearsInBeauty = false;
  bool appearsInWellness = false;
  bool appearsInGoals = false;
  bool appearsInActivity = true;
  bool reminderEnabled = true;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _saveCustomCheckIn() {
    final String title =
        titleController.text.trim();

    final String description =
        descriptionController.text.trim();

    if (title.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final String id =
        'custom_${DateTime.now().millisecondsSinceEpoch}';

    CheckInService.instance.addCheckIn(
      CheckInModel(
        id: id,
        title: title,
        description: description.isEmpty
            ? 'Custom check-in task.'
            : description,
        icon: Icons.add_task_rounded,
        frequency: frequency,
        category: category,
        linkedToGoal: appearsInGoals,
        goalId: appearsInGoals ? '${id}_goal' : null,
        appearsOnDashboard: appearsOnDashboard,
        appearsInBeauty: appearsInBeauty,
        appearsInWellness: appearsInWellness,
        appearsInGoals: appearsInGoals,
        appearsInActivity: appearsInActivity,
        reminderEnabled: reminderEnabled,
        reminderTime: const TimeOfDay(
          hour: 9,
          minute: 0,
        ),
        createdAt: DateTime.now(),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _CiantisColors.cream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            40,
          ),
          children: [
            Row(
              children: [
                _SoftIconButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: () => Navigator.pop(context),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _saveCustomCheckIn,
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _CiantisColors.deepBrown,
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: _CiantisColors.card,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        letterSpacing: .4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text(
              'Custom Check-In',
              style: TextStyle(
                color: _CiantisColors.ink,
                fontSize: 38,
                fontWeight: FontWeight.w300,
                height: .96,
                letterSpacing: -1.2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'CREATE YOUR OWN REMINDER HABIT',
              style: TextStyle(
                color: _CiantisColors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.4,
              ),
            ),
            const SizedBox(height: 22),
            _InputBox(
              controller: titleController,
              label: 'Task name',
              hint: 'Example: Clean makeup bag',
            ),
            const SizedBox(height: 12),
            _InputBox(
              controller: descriptionController,
              label: 'Description',
              hint: 'Optional note',
              maxLines: 4,
            ),
            const SizedBox(height: 18),
            _DropdownBox<CheckInFrequency>(
              label: 'Frequency',
              value: frequency,
              values: CheckInFrequency.values,
              display: (value) =>
                  value.name[0].toUpperCase() +
                  value.name.substring(1),
              onChanged: (value) {
                setState(() {
                  frequency = value;
                });
              },
            ),
            const SizedBox(height: 12),
            _DropdownBox<CheckInCategory>(
              label: 'Category',
              value: category,
              values: CheckInCategory.values,
              display: (value) =>
                  value.name[0].toUpperCase() +
                  value.name.substring(1),
              onChanged: (value) {
                setState(() {
                  category = value;
                });
              },
            ),
            const SizedBox(height: 18),
            _CustomToggleRow(
              label: 'Show on Dashboard',
              value: appearsOnDashboard,
              onChanged: (value) {
                setState(() {
                  appearsOnDashboard = value;
                });
              },
            ),
            _CustomToggleRow(
              label: 'Show in Beauty',
              value: appearsInBeauty,
              onChanged: (value) {
                setState(() {
                  appearsInBeauty = value;
                });
              },
            ),
            _CustomToggleRow(
              label: 'Show in Wellness',
              value: appearsInWellness,
              onChanged: (value) {
                setState(() {
                  appearsInWellness = value;
                });
              },
            ),
            _CustomToggleRow(
              label: 'Connect to Goals',
              value: appearsInGoals,
              onChanged: (value) {
                setState(() {
                  appearsInGoals = value;
                });
              },
            ),
            _CustomToggleRow(
              label: 'Add to Recent Activity',
              value: appearsInActivity,
              onChanged: (value) {
                setState(() {
                  appearsInActivity = value;
                });
              },
            ),
            _CustomToggleRow(
              label: 'Reminder Enabled',
              value: reminderEnabled,
              onChanged: (value) {
                setState(() {
                  reminderEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InputBox extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;

  const _InputBox({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: _CiantisColors.ink,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor:
            _CiantisColors.card.withOpacity(.88),
        labelStyle: const TextStyle(
          color: _CiantisColors.taupe,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
        hintStyle: const TextStyle(
          color: _CiantisColors.muted,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: _CiantisColors.softBorder,
            width: .75,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: _CiantisColors.gold,
            width: .9,
          ),
        ),
      ),
    );
  }
}

class _DropdownBox<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> values;
  final String Function(T value) display;
  final ValueChanged<T> onChanged;

  const _DropdownBox({
    required this.label,
    required this.value,
    required this.values,
    required this.display,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: _CiantisColors.card.withOpacity(.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _CiantisColors.softBorder,
          width: .75,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: _CiantisColors.card,
          iconEnabledColor: _CiantisColors.taupe,
          style: const TextStyle(
            color: _CiantisColors.ink,
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
          items: values.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(display(item)),
            );
          }).toList(),
          onChanged: (value) {
            if (value == null) return;
            onChanged(value);
          },
        ),
      ),
    );
  }
}

class _CustomToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _CustomToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: _CiantisColors.card.withOpacity(.86),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: _CiantisColors.softBorder,
          width: .75,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _CiantisColors.ink,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: _CiantisColors.complete,
          ),
        ],
      ),
    );
  }
}
