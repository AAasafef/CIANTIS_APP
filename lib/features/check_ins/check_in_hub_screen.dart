import 'package:flutter/material.dart';

class CheckInHubScreen extends StatefulWidget {
  const CheckInHubScreen({
    super.key,
  });

  @override
  State<CheckInHubScreen> createState() =>
      _CheckInHubScreenState();
}

class _CheckInHubScreenState
    extends State<CheckInHubScreen> {
  String selectedFilter = 'Today';

  final List<_CheckInItem> checkIns = [
    _CheckInItem(
      title: 'Drink Water',
      subtitle: 'Shared with Wellness + Goals',
      category: 'Wellness',
      frequency: 'Daily',
      icon: Icons.water_drop_outlined,
      progressLabel: '6 / 10 cups',
      isComplete: false,
      isDue: true,
    ),
    _CheckInItem(
      title: 'Skincare Routine',
      subtitle: 'Cleanse, moisturize, protect',
      category: 'Beauty',
      frequency: 'Daily',
      icon: Icons.spa_outlined,
      progressLabel: 'Not complete',
      isComplete: false,
      isDue: true,
    ),
    _CheckInItem(
      title: 'Clean Inside Ears',
      subtitle: 'Gentle q-tip reminder',
      category: 'Beauty Hygiene',
      frequency: 'Weekly',
      icon: Icons.hearing_outlined,
      progressLabel: 'Due today',
      isComplete: false,
      isDue: true,
    ),
    _CheckInItem(
      title: 'Body Moisture',
      subtitle: 'Lotion, oil, or body butter',
      category: 'Beauty',
      frequency: 'Daily',
      icon: Icons.auto_awesome_outlined,
      progressLabel: 'Not complete',
      isComplete: false,
      isDue: true,
    ),
    _CheckInItem(
      title: 'Hair Protection',
      subtitle: 'Wrap, bonnet, scarf, or reset',
      category: 'Hair',
      frequency: 'Daily',
      icon: Icons.face_retouching_natural_outlined,
      progressLabel: 'Complete',
      isComplete: true,
      isDue: true,
    ),
    _CheckInItem(
      title: 'Vitamins',
      subtitle: 'Shared with Health + Wellness',
      category: 'Health',
      frequency: 'Daily',
      icon: Icons.medication_liquid_outlined,
      progressLabel: 'Not complete',
      isComplete: false,
      isDue: true,
    ),
    _CheckInItem(
      title: 'Shave / Groom',
      subtitle: 'Twice monthly default',
      category: 'Beauty Grooming',
      frequency: 'Monthly',
      icon: Icons.content_cut_rounded,
      progressLabel: 'Not due',
      isComplete: false,
      isDue: false,
    ),
    _CheckInItem(
      title: 'Deep Clean Beauty Tools',
      subtitle: 'Brushes, combs, razors, tools',
      category: 'Beauty',
      frequency: 'Monthly',
      icon: Icons.cleaning_services_outlined,
      progressLabel: 'Not due',
      isComplete: false,
      isDue: false,
    ),
    _CheckInItem(
      title: 'New Year Reset',
      subtitle: 'Review goals, routines, supplies',
      category: 'Life',
      frequency: 'Yearly',
      icon: Icons.workspace_premium_outlined,
      progressLabel: 'Jan 1 / Dec 31',
      isComplete: false,
      isDue: false,
    ),
  ];

  List<_CheckInItem> get visibleCheckIns {
    if (selectedFilter == 'Today') {
      return checkIns
          .where((item) => item.isDue)
          .toList();
    }

    if (selectedFilter == 'Daily' ||
        selectedFilter == 'Weekly' ||
        selectedFilter == 'Monthly' ||
        selectedFilter == 'Yearly') {
      return checkIns
          .where((item) =>
              item.frequency == selectedFilter &&
              item.isDue)
          .toList();
    }

    return checkIns;
  }

  int get dueCount =>
      checkIns.where((item) => item.isDue).length;

  int get completeCount => checkIns
      .where((item) => item.isDue && item.isComplete)
      .length;

  void _toggleComplete(_CheckInItem item) {
    setState(() {
      item.isComplete = !item.isComplete;
      item.progressLabel =
          item.isComplete ? 'Complete' : 'Not complete';
    });
  }

  void _openTaskDetails(_CheckInItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return _CheckInDetailSheet(
          item: item,
          onComplete: () {
            Navigator.pop(context);
            _toggleComplete(item);
          },
        );
      },
    );
  }

  void _openCustomCheckIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const _CustomCheckInPlaceholderScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double percent =
        dueCount == 0 ? 0 : completeCount / dueCount;

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
                14,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _SoftIconButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      _SoftIconButton(
                        icon: Icons.tune_rounded,
                        onTap: () {
                          _showSettingsPreview(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Check-Ins',
                    style: TextStyle(
                      fontSize: 44,
                      height: .96,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -1.4,
                      color: _CiantisColors.ink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'SMALL HABITS • ONE SYSTEM',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3,
                      color: _CiantisColors.muted,
                    ),
                  ),
                  const SizedBox(height: 22),
                  _ProgressSummaryCard(
                    completeCount: completeCount,
                    dueCount: dueCount,
                    percent: percent,
                  ),
                  const SizedBox(height: 18),
                  _FilterBar(
                    selected: selectedFilter,
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value;
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
                          selectedFilter == 'Today'
                              ? 'Due Today'
                              : selectedFilter,
                          style: const TextStyle(
                            color: _CiantisColors.ink,
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -.35,
                          ),
                        ),
                      ),
                      Text(
                        '${visibleCheckIns.length} showing',
                        style: const TextStyle(
                          color: _CiantisColors.muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...visibleCheckIns.map(
                    (item) => _CheckInTile(
                      item: item,
                      onTap: () => _openTaskDetails(item),
                      onToggle: () => _toggleComplete(item),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _CustomTaskButton(
                    onTap: _openCustomCheckIn,
                  ),
                  const SizedBox(height: 14),
                  const _SyncCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsPreview(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
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
                  'Check-In Settings',
                  style: TextStyle(
                    color: _CiantisColors.ink,
                    fontSize: 26,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Later this will control weekly reset day, monthly reset day, reminders, snooze options, and which spaces each check-in appears in.',
                  style: TextStyle(
                    color: _CiantisColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                const _SettingsPreviewRow(
                  label: 'Weekly reset day',
                  value: 'Sunday',
                ),
                const _SettingsPreviewRow(
                  label: 'Monthly reset day',
                  value: '1st or last day',
                ),
                const _SettingsPreviewRow(
                  label: 'Yearly reset',
                  value: 'Jan 1 / Dec 31',
                ),
                const _SettingsPreviewRow(
                  label: 'Reminder time',
                  value: '9:00 AM',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CheckInItem {
  final String title;
  final String subtitle;
  final String category;
  final String frequency;
  final IconData icon;
  String progressLabel;
  bool isComplete;
  final bool isDue;

  _CheckInItem({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.frequency,
    required this.icon,
    required this.progressLabel,
    required this.isComplete,
    required this.isDue,
  });
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
          color: _CiantisColors.card.withOpacity(.92),
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

class _ProgressSummaryCard extends StatelessWidget {
  final int completeCount;
  final int dueCount;
  final double percent;

  const _ProgressSummaryCard({
    required this.completeCount,
    required this.dueCount,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final bool allDone =
        dueCount > 0 && completeCount >= dueCount;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _CiantisColors.card.withOpacity(.90),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: allDone
              ? _CiantisColors.complete.withOpacity(.55)
              : _CiantisColors.softBorder,
          width: .8,
        ),
        boxShadow: [
          BoxShadow(
            color: (allDone
                    ? _CiantisColors.complete
                    : _CiantisColors.gold)
                .withOpacity(.12),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 92,
            width: 92,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 86,
                  width: 86,
                  child: CircularProgressIndicator(
                    value: percent,
                    strokeWidth: 8,
                    backgroundColor:
                        _CiantisColors.softTaupe,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(
                      allDone
                          ? _CiantisColors.complete
                          : _CiantisColors.gold,
                    ),
                  ),
                ),
                Text(
                  '$completeCount/$dueCount',
                  style: const TextStyle(
                    color: _CiantisColors.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Today’s Check-Ins',
                  style: TextStyle(
                    color: _CiantisColors.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.25,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Daily shows every day. Weekly, monthly, and yearly only show when due. Completed items can disappear after reset later.',
                  style: TextStyle(
                    color: _CiantisColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _FilterBar({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      'Today',
      'All',
      'Daily',
      'Weekly',
      'Monthly',
      'Yearly',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((filter) {
          final bool active = selected == filter;

          return GestureDetector(
            onTap: () => onChanged(filter),
            child: Container(
              margin: const EdgeInsets.only(right: 9),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: active
                    ? _CiantisColors.deepBrown
                    : _CiantisColors.card.withOpacity(.88),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: active
                      ? _CiantisColors.deepBrown
                      : _CiantisColors.softBorder,
                  width: .75,
                ),
              ),
              child: Text(
                filter,
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

class _CheckInTile extends StatelessWidget {
  final _CheckInItem item;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const _CheckInTile({
    required this.item,
    required this.onTap,
    required this.onToggle,
  });

  Color get statusColor {
    if (item.isComplete) {
      return _CiantisColors.complete;
    }

    if (item.isDue) {
      return _CiantisColors.gold;
    }

    return _CiantisColors.softBorder;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        color: _CiantisColors.card.withOpacity(.88),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: statusColor.withOpacity(
            item.isComplete ? .56 : .34,
          ),
          width: .85,
        ),
        boxShadow: [
          if (item.isComplete)
            BoxShadow(
              color: _CiantisColors.complete.withOpacity(.12),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 6,
        ),
        leading: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: _CiantisColors.softTaupe.withOpacity(.86),
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
          '${item.subtitle}  •  ${item.frequency}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: _CiantisColors.muted,
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
        trailing: GestureDetector(
          onTap: item.isDue ? onToggle : null,
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.isComplete
                  ? _CiantisColors.complete.withOpacity(.12)
                  : Colors.transparent,
              border: Border.all(
                color: statusColor.withOpacity(.82),
                width: .9,
              ),
            ),
            child: Icon(
              item.isComplete
                  ? Icons.check_rounded
                  : Icons.circle_outlined,
              color: statusColor,
              size: item.isComplete ? 19 : 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckInDetailSheet extends StatelessWidget {
  final _CheckInItem item;
  final VoidCallback onComplete;

  const _CheckInDetailSheet({
    required this.item,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final bool complete = item.isComplete;

    return Container(
      decoration: const BoxDecoration(
        color: _CiantisColors.cream,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        22,
        14,
        22,
        34,
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: _CiantisColors.ink,
                      fontSize: 27,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -.4,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close_rounded,
                    color: _CiantisColors.ink,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Center(
              child: Container(
                height: 112,
                width: 112,
                decoration: BoxDecoration(
                  color: _CiantisColors.card,
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(
                    color: complete
                        ? _CiantisColors.complete
                            .withOpacity(.58)
                        : _CiantisColors.softBorder,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (complete
                              ? _CiantisColors.complete
                              : _CiantisColors.gold)
                          .withOpacity(.13),
                      blurRadius: 26,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Icon(
                  complete
                      ? Icons.check_rounded
                      : item.icon,
                  color: complete
                      ? _CiantisColors.complete
                      : _CiantisColors.taupe,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              item.subtitle,
              style: const TextStyle(
                color: _CiantisColors.ink,
                fontSize: 16,
                fontWeight: FontWeight.w300,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Small habits count. This check-in keeps your routine visible without making the app feel heavy.',
              style: TextStyle(
                color: _CiantisColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w300,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18),
            _InfoLine(label: 'Frequency', value: item.frequency),
            _InfoLine(label: 'Category', value: item.category),
            _InfoLine(
              label: 'Progress',
              value: item.progressLabel,
            ),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: item.isDue && !complete
                  ? onComplete
                  : null,
              child: Container(
                height: 52,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: complete
                      ? _CiantisColors.complete
                          .withOpacity(.12)
                      : _CiantisColors.deepBrown,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: complete
                        ? _CiantisColors.complete
                            .withOpacity(.58)
                        : _CiantisColors.deepBrown,
                    width: .8,
                  ),
                ),
                child: Text(
                  complete
                      ? 'Completed Today'
                      : item.isDue
                          ? 'Mark as Complete'
                          : 'Not Due Yet',
                  style: TextStyle(
                    color: complete
                        ? _CiantisColors.complete
                        : _CiantisColors.card,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    letterSpacing: .4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _CiantisColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: _CiantisColors.ink,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomTaskButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CustomTaskButton({
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

class _SyncCard extends StatelessWidget {
  const _SyncCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _CiantisColors.softTaupe.withOpacity(.62),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _CiantisColors.softBorder,
          width: .75,
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.link_rounded,
            color: _CiantisColors.taupe,
            size: 21,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Shared goals stay synced. Water checked off in Wellness updates Beauty, Dashboard, and Goals automatically later.',
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

class _SettingsPreviewRow extends StatelessWidget {
  final String label;
  final String value;

  const _SettingsPreviewRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
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

class _CustomCheckInPlaceholderScreen extends StatelessWidget {
  const _CustomCheckInPlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _CiantisColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            24,
            24,
            24,
            34,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _SoftIconButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 30),
              const Text(
                'Custom Check-In',
                style: TextStyle(
                  fontSize: 40,
                  height: .96,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.2,
                  color: _CiantisColors.ink,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Later this becomes the form where you create your own task, choose frequency, reminder time, and which CIANTIS spaces it belongs to.',
                style: TextStyle(
                  color: _CiantisColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
