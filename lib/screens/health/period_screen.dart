import 'package:flutter/material.dart';

import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../calendar/calendar_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

import 'period/cycle_calendar_screen.dart';
import 'period/cycle_comfort_center_screen.dart';
import 'period/cycle_day_editor_screen.dart';
import 'period/cycle_flow_screen.dart';
import 'period/cycle_history_screen.dart';
import 'period/cycle_notes_screen.dart';
import 'period/cycle_symptoms_screen.dart';

class PeriodScreen extends StatefulWidget {
  const PeriodScreen({super.key});

  @override
  State<PeriodScreen> createState() => _PeriodScreenState();
}

class _PeriodScreenState extends State<PeriodScreen> {
  final ScrollController scrollController = ScrollController();
  final ScrollController dateScrollController = ScrollController();
  final PageController pageController = PageController();

  bool showBottomNav = true;

  late final List<DateTime> dateStripDays;

  DateTime selectedDate = DateTime.now();

  final List<PeriodHistoryItem> periodHistory = [
    PeriodHistoryItem(
      start: DateTime(2026, 3, 12),
      end: DateTime(2026, 3, 16),
      symptoms: 'Abd. pain, Back pain, Spotting, Bloating, Fatigue',
      flow: 'Medium flow',
    ),
    PeriodHistoryItem(
      start: DateTime(2026, 4, 3),
      end: DateTime(2026, 4, 12),
      symptoms: 'Heavy flow, Abd. pain, Cramping, Headache, Fatigue',
      flow: 'Heavy flow',
    ),
    PeriodHistoryItem(
      start: DateTime(2026, 5, 6),
      end: DateTime(2026, 5, 11),
      symptoms: 'Moderate flow, Back pain, Bloating, Mood swings',
      flow: 'Moderate flow',
    ),
    PeriodHistoryItem(
      start: DateTime(2026, 2, 7),
      end: DateTime(2026, 2, 12),
      symptoms: 'Light flow, Abd. pain, Breast tenderness',
      flow: 'Light flow',
    ),
    PeriodHistoryItem(
      start: DateTime(2026, 1, 9),
      end: DateTime(2026, 1, 14),
      symptoms: 'Moderate flow, Cramping, Fatigue',
      flow: 'Moderate flow',
    ),
    PeriodHistoryItem(
      start: DateTime(2025, 12, 12),
      end: DateTime(2025, 12, 17),
      symptoms: 'Light flow, Spotting, Bloating, Headache',
      flow: 'Light flow',
    ),
  ];

  final Map<String, List<CycleLogItem>> dailyLogs = {};

  @override
  void initState() {
    super.initState();

    dateStripDays = List.generate(
      241,
      (index) {
        final today = DateTime.now();
        return DateTime(
          today.year,
          today.month,
          today.day,
        ).add(Duration(days: index - 120));
      },
    );

    _createSampleLogs();

    scrollController.addListener(() {
      final direction =
          scrollController.position.userScrollDirection;

      if (direction.toString().contains('reverse') &&
          showBottomNav) {
        setState(() {
          showBottomNav = false;
        });
      }

      if (direction.toString().contains('forward') &&
          !showBottomNav) {
        setState(() {
          showBottomNav = true;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (dateScrollController.hasClients) {
        dateScrollController.jumpTo(120 * 66);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    dateScrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  void _createSampleLogs() {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    dailyLogs[_dateKey(today)] = [
      CycleLogItem(
        title: 'Period',
        subtitle: 'Medium flow',
        icon: Icons.water_drop_outlined,
      ),
      CycleLogItem(
        title: 'Abdominal Pain',
        subtitle: 'Medium',
        icon: Icons.waves_rounded,
      ),
      CycleLogItem(
        title: 'Back Pain',
        subtitle: 'Mild',
        icon: Icons.self_improvement_outlined,
      ),
      CycleLogItem(
        title: 'Fatigue',
        subtitle: 'High',
        icon: Icons.bolt_outlined,
      ),
      CycleLogItem(
        title: 'Discharge',
        subtitle: 'Clear, stretchy',
        icon: Icons.opacity_rounded,
      ),
    ];

    final yesterday = today.subtract(const Duration(days: 1));

    dailyLogs[_dateKey(yesterday)] = [
      CycleLogItem(
        title: 'Headache',
        subtitle: 'Mild',
        icon: Icons.psychology_alt_outlined,
      ),
      CycleLogItem(
        title: 'Mood',
        subtitle: 'Sensitive',
        icon: Icons.favorite_border_rounded,
      ),
    ];
  }

  void _openGridMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const GridMenu(),
    );
  }

  void _openScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _handleBottomNavTap(int index) {
    if (index == 0) {
      _openScreen(const SpacesScreen());
      return;
    }

    if (index == 1) {
      _openScreen(const CalendarScreen());
      return;
    }

    if (index == 2) {
      _openGridMenu();
      return;
    }

    if (index == 3) {
      _openScreen(
        const ComingSoonScreen(
          title: 'AI',
          subtitle:
              'Your assistant for voice commands, reminders, summaries, and hands-free navigation will connect here.',
          icon: Icons.auto_awesome_rounded,
        ),
      );
      return;
    }

    if (index == 4) {
      _openScreen(const SettingsScreen());
    }
  }

  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = DateTime(date.year, date.month, date.day);
    });
  }

  List<CycleLogItem> get selectedLogs {
    return dailyLogs[_dateKey(selectedDate)] ?? [];
  }

  int get periodDay {
    for (final period in periodHistory) {
      if (!selectedDate.isBefore(period.start) &&
          !selectedDate.isAfter(period.end)) {
        return selectedDate.difference(period.start).inDays + 1;
      }
    }

    return 0;
  }

  DateTime get nextPeriodDate {
    return DateTime(2026, 4, 8);
  }

  void _openDayEditor() {
    _openScreen(
      CycleDayEditorScreen(
        selectedDate: selectedDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      drawer: const CiantisSideDrawer(),
      extendBody: true,
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        offset:
            showBottomNav ? Offset.zero : const Offset(0, 1.25),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: showBottomNav ? 1 : 0,
          child: SpacesBottomNavBar(
            currentIndex: 2,
            onTap: _handleBottomNavTap,
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          _HomePage(
            scrollController: scrollController,
            dateScrollController: dateScrollController,
            dateStripDays: dateStripDays,
            selectedDate: selectedDate,
            selectedLogs: selectedLogs,
            periodDay: periodDay,
            nextPeriodDate: nextPeriodDate,
            periodHistory: periodHistory,
            onDateSelected: _selectDate,
            onAddTap: _openDayEditor,
            onCalendar: () => _openScreen(
              const CycleCalendarScreen(),
            ),
            onSymptoms: () => _openScreen(
              const CycleSymptomsScreen(),
            ),
            onFlow: () => _openScreen(
              const CycleFlowScreen(),
            ),
            onNotes: () => _openScreen(
              const CycleNotesScreen(),
            ),
            onComfort: () => _openScreen(
              const CycleComfortCenterScreen(),
            ),
            onHistory: () {
              pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
              );
            },
            onLogTap: (item) {
              _openScreen(
                ComingSoonScreen(
                  title: item.title,
                  subtitle:
                      '${item.title} details and editing will connect here.',
                  icon: item.icon,
                ),
              );
            },
          ),
          _HistoryPanel(
            history: periodHistory,
            onClose: () {
              pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
              );
            },
            onOpenFullHistory: () => _openScreen(
              const CycleHistoryScreen(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  final ScrollController scrollController;
  final ScrollController dateScrollController;
  final List<DateTime> dateStripDays;
  final DateTime selectedDate;
  final List<CycleLogItem> selectedLogs;
  final int periodDay;
  final DateTime nextPeriodDate;
  final List<PeriodHistoryItem> periodHistory;

  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onAddTap;
  final VoidCallback onCalendar;
  final VoidCallback onSymptoms;
  final VoidCallback onFlow;
  final VoidCallback onNotes;
  final VoidCallback onComfort;
  final VoidCallback onHistory;
  final ValueChanged<CycleLogItem> onLogTap;

  const _HomePage({
    required this.scrollController,
    required this.dateScrollController,
    required this.dateStripDays,
    required this.selectedDate,
    required this.selectedLogs,
    required this.periodDay,
    required this.nextPeriodDate,
    required this.periodHistory,
    required this.onDateSelected,
    required this.onAddTap,
    required this.onCalendar,
    required this.onSymptoms,
    required this.onFlow,
    required this.onNotes,
    required this.onComfort,
    required this.onHistory,
    required this.onLogTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 128),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(onAddTap: onAddTap),
            const SizedBox(height: 24),
            _ScrollableDateStrip(
              controller: dateScrollController,
              days: dateStripDays,
              selectedDate: selectedDate,
              periodHistory: periodHistory,
              onSelected: onDateSelected,
            ),
            const SizedBox(height: 22),
            _SelectedDayLabel(selectedDate: selectedDate),
            const SizedBox(height: 12),
            _OverviewCard(
              periodDay: periodDay,
              selectedLogs: selectedLogs,
              selectedDate: selectedDate,
              nextPeriodDate: nextPeriodDate,
              onEditDay: onAddTap,
            ),
            const SizedBox(height: 16),
            _FeatureRail(
              onCalendar: onCalendar,
              onSymptoms: onSymptoms,
              onFlow: onFlow,
              onNotes: onNotes,
              onComfort: onComfort,
              onHistory: onHistory,
            ),
            const SizedBox(height: 20),
            _TimelineHeader(selectedDate: selectedDate),
            const SizedBox(height: 10),
            if (selectedLogs.isEmpty)
              _EmptyDailyLog(onAddTap: onAddTap)
            else
              Container(
                decoration: _cardDecoration(radius: 24),
                child: Column(
                  children: selectedLogs.map((item) {
                    final isLast = item == selectedLogs.last;

                    return _DailyLogRow(
                      item: item,
                      showDivider: !isLast,
                      onTap: () => onLogTap(item),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 16),
            _SmallHintCard(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onAddTap;

  const _Header({
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cycle',
                style: TextStyle(
                  fontSize: 58,
                  height: .9,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -2.4,
                  color: Color(0xFF241D18),
                ),
              ),
              SizedBox(height: 13),
              Text(
                'WOMEN’S HEALTH',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 4.8,
                  color: Color(0xFF9B8F84),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onAddTap,
          child: Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFFBF8F4).withOpacity(.9),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFE2D8CD),
                width: .7,
              ),
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Color(0xFF241D18),
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class _ScrollableDateStrip extends StatelessWidget {
  final ScrollController controller;
  final List<DateTime> days;
  final DateTime selectedDate;
  final List<PeriodHistoryItem> periodHistory;
  final ValueChanged<DateTime> onSelected;

  const _ScrollableDateStrip({
    required this.controller,
    required this.days,
    required this.selectedDate,
    required this.periodHistory,
    required this.onSelected,
  });

  bool _isPeriodDay(DateTime date) {
    for (final period in periodHistory) {
      final day = DateTime(date.year, date.month, date.day);
      final start = DateTime(
        period.start.year,
        period.start.month,
        period.start.day,
      );
      final end = DateTime(
        period.end.year,
        period.end.month,
        period.end.day,
      );

      if (!day.isBefore(start) && !day.isAfter(end)) {
        return true;
      }
    }

    return false;
  }

  Color _periodDotColor(DateTime date) {
    for (final period in periodHistory) {
      final day = DateTime(date.year, date.month, date.day);
      final start = DateTime(
        period.start.year,
        period.start.month,
        period.start.day,
      );
      final end = DateTime(
        period.end.year,
        period.end.month,
        period.end.day,
      );

      if (!day.isBefore(start) && !day.isAfter(end)) {
        final total = end.difference(start).inDays + 1;
        final current = day.difference(start).inDays;
        final percent = total <= 1 ? 0.0 : current / (total - 1);

        return Color.lerp(
          const Color(0xFFB65B52),
          const Color(0xFFDDB0AA),
          percent,
        )!;
      }
    }

    return const Color(0xFFB65B52);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      decoration: _cardDecoration(radius: 30),
      child: ListView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final date = days[index];
          final selected = _isSameDay(date, selectedDate);
          final today = _isSameDay(date, DateTime.now());
          final periodDay = _isPeriodDay(date);

          return GestureDetector(
            onTap: () => onSelected(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 58,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF241D18)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: today && !selected
                    ? Border.all(
                        color: const Color(0xFFC6A06B),
                        width: 1,
                      )
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weekdayMini(date.weekday),
                    style: TextStyle(
                      color: selected
                          ? const Color(0xFFFFF9F1)
                          : const Color(0xFF9B8F84),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: selected
                          ? const Color(0xFFFFF9F1)
                          : const Color(0xFF241D18),
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 7),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 5,
                    width: periodDay ? 5 : 0,
                    decoration: BoxDecoration(
                      color: periodDay
                          ? _periodDotColor(date)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SelectedDayLabel extends StatelessWidget {
  final DateTime selectedDate;

  const _SelectedDayLabel({
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_weekdayName(selectedDate.weekday).toUpperCase()}, ${_monthName(selectedDate.month).toUpperCase()} ${selectedDate.day}, ${selectedDate.year}',
      style: const TextStyle(
        color: Color(0xFF8B7D72),
        fontSize: 11,
        fontWeight: FontWeight.w300,
        letterSpacing: 2.4,
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final int periodDay;
  final List<CycleLogItem> selectedLogs;
  final DateTime selectedDate;
  final DateTime nextPeriodDate;
  final VoidCallback onEditDay;

  const _OverviewCard({
    required this.periodDay,
    required this.selectedLogs,
    required this.selectedDate,
    required this.nextPeriodDate,
    required this.onEditDay,
  });

  @override
  Widget build(BuildContext context) {
    final hasPeriod =
        selectedLogs.any((item) => item.title.toLowerCase() == 'period');

    final title = hasPeriod && periodDay > 0
        ? 'Period Day $periodDay'
        : selectedLogs.isEmpty
            ? 'No Logs Yet'
            : '${selectedLogs.length} Things Logged';

    final subtitle = selectedLogs.isEmpty
        ? 'Tap add to log symptoms, discharge, flow, mood, or notes.'
        : selectedLogs.map((item) => item.title).join(' • ');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.86),
        borderRadius: BorderRadius.circular(34),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFBF6),
            Color(0xFFF7F0E8),
            Color(0xFFEDE2D6),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0B241D18),
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'OVERVIEW',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 11,
              fontWeight: FontWeight.w300,
              letterSpacing: 3.1,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 32,
              height: 1,
              fontWeight: FontWeight.w300,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              GestureDetector(
                onTap: onEditDay,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8D8C8),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    'Edit Day',
                    style: TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'NEXT PERIOD',
                    style: TextStyle(
                      color: Color(0xFF8B7D72),
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.8,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${_shortMonth(nextPeriodDate.month)} ${nextPeriodDate.day}',
                    style: const TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureRail extends StatelessWidget {
  final VoidCallback onCalendar;
  final VoidCallback onSymptoms;
  final VoidCallback onFlow;
  final VoidCallback onNotes;
  final VoidCallback onComfort;
  final VoidCallback onHistory;

  const _FeatureRail({
    required this.onCalendar,
    required this.onSymptoms,
    required this.onFlow,
    required this.onNotes,
    required this.onComfort,
    required this.onHistory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          _FeatureButton(
            icon: Icons.calendar_month_outlined,
            label: 'Calendar',
            onTap: onCalendar,
          ),
          _FeatureButton(
            icon: Icons.spa_outlined,
            label: 'Symptoms',
            onTap: onSymptoms,
          ),
          _FeatureButton(
            icon: Icons.water_drop_outlined,
            label: 'Flow',
            onTap: onFlow,
          ),
          _FeatureButton(
            icon: Icons.edit_note_rounded,
            label: 'Notes',
            onTap: onNotes,
          ),
          _FeatureButton(
            icon: Icons.favorite_border_rounded,
            label: 'Comfort',
            onTap: onComfort,
          ),
          _FeatureButton(
            icon: Icons.history_rounded,
            label: 'History',
            onTap: onHistory,
          ),
        ],
      ),
    );
  }
}

class _FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FeatureButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 82,
        margin: const EdgeInsets.only(right: 8),
        decoration: _cardDecoration(radius: 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF241D18),
              size: 20,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF8B7D72),
                fontSize: 11,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineHeader extends StatelessWidget {
  final DateTime selectedDate;

  const _TimelineHeader({
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${selectedDate.day}',
          style: const TextStyle(
            color: Color(0xFF241D18),
            fontSize: 32,
            fontWeight: FontWeight.w300,
            height: 1,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          _weekdayShort(selectedDate.weekday),
          style: const TextStyle(
            color: Color(0xFF241D18),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: .7,
          ),
        ),
        const Spacer(),
        const Text(
          'TODAY’S LOG',
          style: TextStyle(
            color: Color(0xFFB1A69C),
            fontSize: 9,
            fontWeight: FontWeight.w300,
            letterSpacing: 2.7,
          ),
        ),
      ],
    );
  }
}

class _DailyLogRow extends StatelessWidget {
  final CycleLogItem item;
  final bool showDivider;
  final VoidCallback onTap;

  const _DailyLogRow({
    required this.item,
    required this.showDivider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 11,
            ),
            child: Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4EFE8),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFE2D8CD),
                      width: .7,
                    ),
                  ),
                  child: Icon(
                    item.icon,
                    color: const Color(0xFF241D18),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Color(0xFF241D18),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          color: Color(0xFF8B7D72),
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF8B7D72),
                  size: 19,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Container(
            height: .7,
            margin: const EdgeInsets.only(left: 66),
            color: const Color(0xFFE2D8CD),
          ),
      ],
    );
  }
}

class _EmptyDailyLog extends StatelessWidget {
  final VoidCallback onAddTap;

  const _EmptyDailyLog({
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: _cardDecoration(radius: 24),
        child: const Text(
          'No cycle notes logged for this day. Tap here to add period, symptoms, discharge, mood, flow, or notes.',
          style: TextStyle(
            color: Color(0xFF8B7D72),
            fontSize: 13,
            height: 1.35,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class _SmallHintCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(radius: 24),
      child: const Text(
        'Swipe left to view period history.',
        style: TextStyle(
          color: Color(0xFF8B7D72),
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class _HistoryPanel extends StatelessWidget {
  final List<PeriodHistoryItem> history;
  final VoidCallback onClose;
  final VoidCallback onOpenFullHistory;

  const _HistoryPanel({
    required this.history,
    required this.onClose,
    required this.onOpenFullHistory,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Cycle History',
                    style: TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 34,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -.8,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF8F4).withOpacity(.55),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE2D8CD).withOpacity(.65),
                        width: .7,
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF8B7D72),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...history.map((item) {
              return GestureDetector(
                onTap: onOpenFullHistory,
                child: _HistoryItemCard(item: item),
              );
            }),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: onOpenFullHistory,
              child: Container(
                width: double.infinity,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF241D18),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  'Open Full History',
                  style: TextStyle(
                    color: Color(0xFFFFF9F1),
                    fontSize: 14,
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

class _HistoryItemCard extends StatelessWidget {
  final PeriodHistoryItem item;

  const _HistoryItemCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final days = item.end.difference(item.start).inDays + 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: _cardDecoration(radius: 24),
      child: Row(
        children: [
          Icon(
            Icons.water_drop_rounded,
            color: _historyDropColor(item.flow),
            size: 28,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  '${_shortMonth(item.start.month)} ${item.start.day} – ${_shortMonth(item.end.month)} ${item.end.day}, ${item.end.year}',
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  item.symptoms,
                  style: const TextStyle(
                    color: Color(0xFF6F6258),
                    fontSize: 13,
                    height: 1.35,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                '$days days',
                style: const TextStyle(
                  color: Color(0xFF8B7D72),
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 11),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF6F6258),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _historyDropColor(String flow) {
    final lower = flow.toLowerCase();

    if (lower.contains('heavy')) {
      return const Color(0xFFB65B52);
    }

    if (lower.contains('light')) {
      return const Color(0xFFD5A8A0);
    }

    return const Color(0xFFB97870);
  }
}

class CycleLogItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const CycleLogItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class PeriodHistoryItem {
  final DateTime start;
  final DateTime end;
  final String symptoms;
  final String flow;

  const PeriodHistoryItem({
    required this.start,
    required this.end,
    required this.symptoms,
    required this.flow,
  });
}

BoxDecoration _cardDecoration({
  double radius = 24,
}) {
  return BoxDecoration(
    color: const Color(0xFFFBF8F4).withOpacity(.9),
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(
      color: const Color(0xFFE2D8CD),
      width: .7,
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF241D18).withOpacity(.025),
        blurRadius: 16,
        offset: const Offset(0, 8),
      ),
    ],
  );
}

String _dateKey(DateTime date) {
  return '${date.year}-${date.month}-${date.day}';
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year &&
      a.month == b.month &&
      a.day == b.day;
}

String _weekdayMini(int weekday) {
  const names = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  return names[weekday - 1];
}

String _weekdayShort(int weekday) {
  const names = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];

  return names[weekday - 1];
}

String _weekdayName(int weekday) {
  const names = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  return names[weekday - 1];
}

String _monthName(int month) {
  const names = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return names[month - 1];
}

String _shortMonth(int month) {
  const names = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return names[month - 1];
}
