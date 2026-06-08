import 'package:flutter/material.dart';

import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

import 'add_calendar_entry_screen.dart';
import 'calendar_entry_model.dart';
import 'calendar_entry_service.dart';

enum CalendarViewMode {
  day,
  week,
  month,
  year,
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() =>
      _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final ScrollController scrollController =
      ScrollController();

  DateTime selectedDate = DateTime.now();

  CalendarViewMode viewMode = CalendarViewMode.month;

  bool showBottomNav = true;
  bool monthExpanded = false;
  bool weekStartsOnMonday = false;

  @override
  void initState() {
    super.initState();

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
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _openGridMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return const GridMenu();
      },
    );
  }

  void _openScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  Future<void> _openAddMenu() async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => AddCalendarEntryScreen(
          initialDate: selectedDate,
        ),
      ),
    );

    if (saved == true && mounted) {
      setState(() {});
    }
  }

  void _handleBottomNavTap(int index) {
    if (index == 0) {
      _openScreen(
        const SpacesScreen(),
      );
      return;
    }

    if (index == 1) {
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
      _openScreen(
        const SettingsScreen(),
      );
    }
  }

  Future<void> _pickMonth() async {
    final picked = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _MonthPickerSheet(
          selectedMonth: selectedDate.month,
        );
      },
    );

    if (picked == null) return;

    final lastDay =
        DateTime(selectedDate.year, picked + 1, 0).day;

    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        picked,
        selectedDate.day.clamp(1, lastDay),
      );
      monthExpanded = false;
    });
  }

  Future<void> _pickYear() async {
    final picked = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _YearPickerSheet(
          selectedYear: selectedDate.year,
        );
      },
    );

    if (picked == null) return;

    final lastDay =
        DateTime(picked, selectedDate.month + 1, 0).day;

    setState(() {
      selectedDate = DateTime(
        picked,
        selectedDate.month,
        selectedDate.day.clamp(1, lastDay),
      );
    });
  }

  void _previousYear() {
    setState(() {
      selectedDate = DateTime(
        selectedDate.year - 1,
        selectedDate.month,
        selectedDate.day,
      );
    });
  }

  void _nextYear() {
    setState(() {
      selectedDate = DateTime(
        selectedDate.year + 1,
        selectedDate.month,
        selectedDate.day,
      );
    });
  }

  void _previousMonth() {
    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month - 1,
        1,
      );
      monthExpanded = false;
    });
  }

  void _nextMonth() {
    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month + 1,
        1,
      );
      monthExpanded = false;
    });
  }

  void _previousWeek() {
    setState(() {
      selectedDate = selectedDate.subtract(
        const Duration(days: 7),
      );
    });
  }

  void _nextWeek() {
    setState(() {
      selectedDate = selectedDate.add(
        const Duration(days: 7),
      );
    });
  }

  void _previousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(
        const Duration(days: 1),
      );
    });
  }

  void _nextDay() {
    setState(() {
      selectedDate = selectedDate.add(
        const Duration(days: 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final showAddButton =
        viewMode != CalendarViewMode.year;

    final selectedEntries =
        CalendarEntryService.entriesForDay(selectedDate);

    final entryDayKeys =
        CalendarEntryService.entryDayKeys();

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
            currentIndex: 1,
            onTap: _handleBottomNavTap,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            128,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _Header(
                showAddButton: showAddButton,
                onAddTap: _openAddMenu,
              ),

              const SizedBox(height: 24),

              _ViewModeSelector(
                selectedMode: viewMode,
                onChanged: (mode) {
                  setState(() {
                    viewMode = mode;
                    if (mode == CalendarViewMode.month) {
                      monthExpanded = false;
                    }
                  });
                },
              ),

              const SizedBox(height: 18),

              if (viewMode == CalendarViewMode.year)
                _YearViewHeader(
                  year: selectedDate.year,
                  onTapYear: _pickYear,
                  onPrevious: _previousYear,
                  onNext: _nextYear,
                ),

              if (viewMode == CalendarViewMode.month)
                _MonthHeader(
                  selectedDate: selectedDate,
                  onTapMonth: _pickMonth,
                  onPrevious: _previousMonth,
                  onNext: _nextMonth,
                ),

              if (viewMode == CalendarViewMode.week)
                _WeekHeader(
                  selectedDate: selectedDate,
                  weekStartsOnMonday:
                      weekStartsOnMonday,
                  onPrevious: _previousWeek,
                  onNext: _nextWeek,
                ),

              if (viewMode == CalendarViewMode.day)
                _DayHeader(
                  selectedDate: selectedDate,
                  onPrevious: _previousDay,
                  onNext: _nextDay,
                ),

              const SizedBox(height: 14),

              if (viewMode == CalendarViewMode.year)
                _YearFullCalendarView(
                  selectedDate: selectedDate,
                  weekStartsOnMonday:
                      weekStartsOnMonday,
                  onMonthSelected: (month) {
                    setState(() {
                      selectedDate = DateTime(
                        selectedDate.year,
                        month,
                        1,
                      );
                      viewMode = CalendarViewMode.month;
                      monthExpanded = false;
                    });
                  },
                ),

              if (viewMode == CalendarViewMode.month)
                _MonthCalendarArea(
                  selectedDate: selectedDate,
                  expanded: monthExpanded,
                  weekStartsOnMonday:
                      weekStartsOnMonday,
                  entryDayKeys: entryDayKeys,
                  onDragUpdate: (details) {
                    if (details.delta.dy > 4 &&
                        !monthExpanded) {
                      setState(() {
                        monthExpanded = true;
                      });
                    }

                    if (details.delta.dy < -4 &&
                        monthExpanded) {
                      setState(() {
                        monthExpanded = false;
                      });
                    }
                  },
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),

              if (viewMode == CalendarViewMode.month &&
                  !monthExpanded)
                const SizedBox(height: 18),

              if (viewMode == CalendarViewMode.month &&
                  !monthExpanded)
                _SelectedDateTitle(
                  selectedDate: selectedDate,
                  entryCount: selectedEntries.length,
                ),

              if (viewMode == CalendarViewMode.month &&
                  !monthExpanded)
                const SizedBox(height: 12),

              if (viewMode == CalendarViewMode.month &&
                  !monthExpanded)
                _CompactDayAgenda(
                  selectedDate: selectedDate,
                  entries: selectedEntries,
                  onAddEvent: _openAddMenu,
                  onDeleteEntry: (id) {
                    setState(() {
                      CalendarEntryService.deleteEntry(id);
                    });
                  },
                ),

              if (viewMode == CalendarViewMode.week)
                _WeekTimelineView(
                  selectedDate: selectedDate,
                  weekStartsOnMonday:
                      weekStartsOnMonday,
                ),

              if (viewMode == CalendarViewMode.day)
                _DayTimelineView(
                  selectedDate: selectedDate,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool showAddButton;
  final VoidCallback onAddTap;

  const _Header({
    required this.showAddButton,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Calendar',
                style: TextStyle(
                  fontSize: 48,
                  height: .95,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.6,
                  color: Color(0xFF241D18),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'SCHEDULE & ROUTINES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3.2,
                  color: Color(0xFF8B7D72),
                ),
              ),
            ],
          ),
        ),
        if (showAddButton)
          GestureDetector(
            onTap: onAddTap,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFFBF8F4)
                    .withOpacity(.92),
                borderRadius:
                    BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE2D8CD),
                  width: .7,
                ),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Color(0xFF241D18),
                size: 25,
              ),
            ),
          ),
      ],
    );
  }
}

class _ViewModeSelector extends StatelessWidget {
  final CalendarViewMode selectedMode;
  final ValueChanged<CalendarViewMode> onChanged;

  const _ViewModeSelector({
    required this.selectedMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4)
            .withOpacity(.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Row(
        children: [
          _modeButton('Day', CalendarViewMode.day),
          _modeButton('Week', CalendarViewMode.week),
          _modeButton('Month', CalendarViewMode.month),
          _modeButton('Year', CalendarViewMode.year),
        ],
      ),
    );
  }

  Widget _modeButton(
    String label,
    CalendarViewMode mode,
  ) {
    final selected = selectedMode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          onChanged(mode);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF241D18)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? const Color(0xFFFFF9F1)
                  : const Color(0xFF6F6258),
              fontSize: 12,
              fontWeight: FontWeight.w300,
              letterSpacing: .6,
            ),
          ),
        ),
      ),
    );
  }
}

class _YearViewHeader extends StatelessWidget {
  final int year;
  final VoidCallback onTapYear;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _YearViewHeader({
    required this.year,
    required this.onTapYear,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SmallIconButton(
          icon: Icons.chevron_left_rounded,
          onTap: onPrevious,
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTapYear,
            child: Text(
              '$year',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 34,
                fontWeight: FontWeight.w400,
                letterSpacing: -.6,
              ),
            ),
          ),
        ),
        _SmallIconButton(
          icon: Icons.chevron_right_rounded,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _MonthHeader extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onTapMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _MonthHeader({
    required this.selectedDate,
    required this.onTapMonth,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SmallIconButton(
          icon: Icons.chevron_left_rounded,
          onTap: onPrevious,
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTapMonth,
            child: Text(
              '${_monthName(selectedDate.month)} ${selectedDate.year}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 30,
                fontWeight: FontWeight.w300,
                letterSpacing: -.8,
              ),
            ),
          ),
        ),
        _SmallIconButton(
          icon: Icons.chevron_right_rounded,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _WeekHeader extends StatelessWidget {
  final DateTime selectedDate;
  final bool weekStartsOnMonday;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _WeekHeader({
    required this.selectedDate,
    required this.weekStartsOnMonday,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final days = _weekDays(
      selectedDate,
      weekStartsOnMonday,
    );

    return Row(
      children: [
        _SmallIconButton(
          icon: Icons.chevron_left_rounded,
          onTap: onPrevious,
        ),
        Expanded(
          child: Text(
            '${_shortMonth(days.first.month)} ${days.first.day} - ${_shortMonth(days.last.month)} ${days.last.day}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 28,
              fontWeight: FontWeight.w300,
              letterSpacing: -.7,
            ),
          ),
        ),
        _SmallIconButton(
          icon: Icons.chevron_right_rounded,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _DayHeader extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _DayHeader({
    required this.selectedDate,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SmallIconButton(
          icon: Icons.chevron_left_rounded,
          onTap: onPrevious,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                '${_monthName(selectedDate.month)} ${selectedDate.day}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF241D18),
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -.7,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _weekdayName(selectedDate.weekday),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF8B7D72),
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.4,
                ),
              ),
            ],
          ),
        ),
        _SmallIconButton(
          icon: Icons.chevron_right_rounded,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _SmallIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SmallIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4)
              .withOpacity(.90),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF241D18),
          size: 24,
        ),
      ),
    );
  }
}

class _YearFullCalendarView extends StatelessWidget {
  final DateTime selectedDate;
  final bool weekStartsOnMonday;
  final ValueChanged<int> onMonthSelected;

  const _YearFullCalendarView({
    required this.selectedDate,
    required this.weekStartsOnMonday,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemCount: 12,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 28,
        crossAxisSpacing: 18,
        childAspectRatio: .92,
      ),
      itemBuilder: (context, index) {
        final month = index + 1;

        return GestureDetector(
          onTap: () {
            onMonthSelected(month);
          },
          child: _MiniMonthCalendar(
            year: selectedDate.year,
            month: month,
            selectedDate: selectedDate,
            weekStartsOnMonday: weekStartsOnMonday,
          ),
        );
      },
    );
  }
}

class _MiniMonthCalendar extends StatelessWidget {
  final int year;
  final int month;
  final DateTime selectedDate;
  final bool weekStartsOnMonday;

  const _MiniMonthCalendar({
    required this.year,
    required this.month,
    required this.selectedDate,
    required this.weekStartsOnMonday,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth =
        DateTime(year, month + 1, 0).day;
    final leading = _leadingDays(
      DateTime(year, month, 1),
      weekStartsOnMonday,
    );

    return Column(
      children: [
        Text(
          _shortMonth(month),
          style: TextStyle(
            color: selectedDate.month == month
                ? const Color(0xFF241D18)
                : const Color(0xFF6F6258),
            fontSize: 17,
            fontWeight: selectedDate.month == month
                ? FontWeight.w500
                : FontWeight.w300,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: _weekdayLabels(
            weekStartsOnMonday,
          ).map((label) {
            return Expanded(
              child: Text(
                label.substring(0, 1),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF241D18),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 7),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount: 42,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final number = index - leading + 1;

              if (number < 1 || number > daysInMonth) {
                return const SizedBox();
              }

              final selected =
                  selectedDate.year == year &&
                      selectedDate.month == month &&
                      selectedDate.day == number;

              return Container(
                alignment: Alignment.center,
                decoration: selected
                    ? BoxDecoration(
                        color: const Color(0xFF241D18),
                        borderRadius:
                            BorderRadius.circular(4),
                      )
                    : null,
                child: Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: selected
                        ? const Color(0xFFFFF9F1)
                        : const Color(0xFF241D18),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MonthCalendarArea extends StatelessWidget {
  final DateTime selectedDate;
  final bool expanded;
  final bool weekStartsOnMonday;
  final Set<String> entryDayKeys;
  final GestureDragUpdateCallback onDragUpdate;
  final ValueChanged<DateTime> onDateSelected;

  const _MonthCalendarArea({
    required this.selectedDate,
    required this.expanded,
    required this.weekStartsOnMonday,
    required this.entryDayKeys,
    required this.onDragUpdate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final days = _monthGridDays(
      selectedDate,
      weekStartsOnMonday,
    );

    return GestureDetector(
      onVerticalDragUpdate: onDragUpdate,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        height: expanded ? 540 : 340,
        child: Column(
          children: [
            Row(
              children:
                  _weekdayLabels(weekStartsOnMonday).map((label) {
                return Expanded(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF6F6258),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: expanded ? 18 : 10),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: days.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisExtent: expanded ? 66 : 42,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: expanded ? 10 : 3,
                ),
                itemBuilder: (context, index) {
                  final date = days[index];

                  final currentMonth =
                      date.month == selectedDate.month;

                  final selected =
                      date.year == selectedDate.year &&
                          date.month == selectedDate.month &&
                          date.day == selectedDate.day;

                  final hasEntry =
                      entryDayKeys.contains(_dateKey(date));

                  return GestureDetector(
                    onTap: () {
                      onDateSelected(date);
                    },
                    child: AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 220),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFF241D18)
                            : Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Text(
                            '${date.day}',
                            style: TextStyle(
                              color: selected
                                  ? const Color(0xFFFFF9F1)
                                  : currentMonth
                                      ? const Color(0xFF241D18)
                                      : const Color(0xFFC5B9AE),
                              fontSize: expanded ? 22 : 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          if (hasEntry && currentMonth)
                            Container(
                              margin: const EdgeInsets.only(
                                top: 4,
                              ),
                              height: expanded ? 3 : 4,
                              width: expanded ? 20 : 4,
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFFFFF9F1)
                                    : const Color(0xFFC6A06B),
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedDateTitle extends StatelessWidget {
  final DateTime selectedDate;
  final int entryCount;

  const _SelectedDateTitle({
    required this.selectedDate,
    required this.entryCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${selectedDate.day}',
          style: const TextStyle(
            color: Color(0xFF241D18),
            fontSize: 30,
            fontWeight: FontWeight.w400,
            height: 1,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          _weekdayShort(selectedDate.weekday),
          style: const TextStyle(
            color: Color(0xFF241D18),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: .6,
          ),
        ),
        const Spacer(),
        Text(
          entryCount == 0
              ? 'NO ITEMS'
              : '$entryCount ITEM${entryCount == 1 ? '' : 'S'}',
          style: const TextStyle(
            color: Color(0xFF8B7D72),
            fontSize: 10,
            fontWeight: FontWeight.w300,
            letterSpacing: 2.2,
          ),
        ),
      ],
    );
  }
}

class _CompactDayAgenda extends StatelessWidget {
  final DateTime selectedDate;
  final List<CalendarEntry> entries;
  final VoidCallback onAddEvent;
  final ValueChanged<String> onDeleteEntry;

  const _CompactDayAgenda({
    required this.selectedDate,
    required this.entries,
    required this.onAddEvent,
    required this.onDeleteEntry,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return GestureDetector(
        onTap: onAddEvent,
        child: Container(
          width: double.infinity,
          height: 64,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFBF8F4)
                .withOpacity(.88),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFE2D8CD),
              width: .7,
            ),
          ),
          child: Text(
            'Add event on ${_shortMonth(selectedDate.month)} ${selectedDate.day}',
            style: const TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
    }

    return Column(
      children: entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Dismissible(
            key: ValueKey(entry.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 22),
              decoration: BoxDecoration(
                color: const Color(0xFFB75C5C),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Color(0xFFFFF9F1),
              ),
            ),
            onDismissed: (_) {
              onDeleteEntry(entry.id);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF8F4),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFE2D8CD),
                  width: .7,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 3,
                    height: 58,
                    decoration: BoxDecoration(
                      color: entry.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(width: 14),
                  SizedBox(
                    width: 76,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.startTimeLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF241D18),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry.endTimeLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF8B7D72),
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF241D18),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            if (entry.location.isNotEmpty) ...[
                              const Icon(
                                Icons.location_on_rounded,
                                color: Color(0xFF8B7D72),
                                size: 13,
                              ),
                              const SizedBox(width: 3),
                            ],
                            if (entry.meetingLink.isNotEmpty) ...[
                              const Icon(
                                Icons.link_rounded,
                                color: Color(0xFF8B7D72),
                                size: 13,
                              ),
                              const SizedBox(width: 3),
                            ],
                            Expanded(
                              child: Text(
                                entry.location.isNotEmpty
                                    ? entry.location
                                    : entry.meetingLink.isNotEmpty
                                        ? 'Meeting link added'
                                        : entry.type,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF8B7D72),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF8B7D72),
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _WeekTimelineView extends StatelessWidget {
  final DateTime selectedDate;
  final bool weekStartsOnMonday;

  const _WeekTimelineView({
    required this.selectedDate,
    required this.weekStartsOnMonday,
  });

  @override
  Widget build(BuildContext context) {
    final days = _weekDays(
      selectedDate,
      weekStartsOnMonday,
    );

    return SizedBox(
      height: 900,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 44),
              ...days.map((day) {
                return Expanded(
                  child: Column(
                    children: [
                      Text(
                        _weekdayShort(day.weekday),
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF8B7D72),
                          letterSpacing: .8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${day.day}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              day.day == selectedDate.day
                                  ? FontWeight.w600
                                  : FontWeight.w300,
                          color:
                              day.day == selectedDate.day
                                  ? const Color(0xFF241D18)
                                  : const Color(0xFF6F6258),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              physics:
                  const BouncingScrollPhysics(),
              itemCount: 96,
              itemBuilder: (context, index) {
                final hour = index ~/ 4;
                final minute = (index % 4) * 15;

                return SizedBox(
                  height: 34,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 44,
                        child: Text(
                          minute == 0
                              ? _timeLabel(hour)
                              : '',
                          style: const TextStyle(
                            color: Color(0xFF8B7D72),
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      ...List.generate(7, (_) {
                        return Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: const Color(
                                    0xFFE2D8CD,
                                  ).withOpacity(.75),
                                  width: .5,
                                ),
                                left: BorderSide(
                                  color: const Color(
                                    0xFFE2D8CD,
                                  ).withOpacity(.55),
                                  width: .5,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DayTimelineView extends StatelessWidget {
  final DateTime selectedDate;

  const _DayTimelineView({
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 900,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 96,
        itemBuilder: (context, index) {
          final hour = index ~/ 4;
          final minute = (index % 4) * 15;

          return SizedBox(
            height: 34,
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    minute == 0
                        ? _timeLabel(hour)
                        : '',
                    style: const TextStyle(
                      color: Color(0xFF8B7D72),
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: const Color(0xFFE2D8CD)
                              .withOpacity(.8),
                          width: .6,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MonthPickerSheet extends StatelessWidget {
  final int selectedMonth;

  const _MonthPickerSheet({
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFF4EFE8),
          borderRadius: BorderRadius.circular(28),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 12,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            final month = index + 1;
            final selected = month == selectedMonth;

            return GestureDetector(
              onTap: () {
                Navigator.pop(context, month);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF241D18)
                      : const Color(0xFFFBF8F4),
                  borderRadius:
                      BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE2D8CD),
                    width: .7,
                  ),
                ),
                child: Text(
                  _shortMonth(month),
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFFFFF9F1)
                        : const Color(0xFF241D18),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _YearPickerSheet extends StatelessWidget {
  final int selectedYear;

  const _YearPickerSheet({
    required this.selectedYear,
  });

  @override
  Widget build(BuildContext context) {
    final startYear = selectedYear - 30;

    return SafeArea(
      child: Container(
        height: 420,
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFF4EFE8),
          borderRadius: BorderRadius.circular(28),
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 61,
          itemBuilder: (context, index) {
            final year = startYear + index;
            final selected = year == selectedYear;

            return GestureDetector(
              onTap: () {
                Navigator.pop(context, year);
              },
              child: Container(
                height: 54,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF241D18)
                      : const Color(0xFFFBF8F4),
                  borderRadius:
                      BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE2D8CD),
                    width: .7,
                  ),
                ),
                child: Text(
                  '$year',
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFFFFF9F1)
                        : const Color(0xFF241D18),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<DateTime> _monthGridDays(
  DateTime selectedDate,
  bool weekStartsOnMonday,
) {
  final first =
      DateTime(selectedDate.year, selectedDate.month, 1);
  final leading =
      _leadingDays(first, weekStartsOnMonday);

  final start =
      first.subtract(Duration(days: leading));

  return List.generate(
    42,
    (index) => start.add(
      Duration(days: index),
    ),
  );
}

List<DateTime> _weekDays(
  DateTime date,
  bool weekStartsOnMonday,
) {
  final weekday = date.weekday;

  final offset = weekStartsOnMonday
      ? weekday - 1
      : weekday % 7;

  final start = date.subtract(
    Duration(days: offset),
  );

  return List.generate(
    7,
    (index) => start.add(
      Duration(days: index),
    ),
  );
}

int _leadingDays(
  DateTime firstDay,
  bool weekStartsOnMonday,
) {
  if (weekStartsOnMonday) {
    return firstDay.weekday - 1;
  }

  return firstDay.weekday % 7;
}

List<String> _weekdayLabels(bool mondayStart) {
  return mondayStart
      ? ['M', 'T', 'W', 'T', 'F', 'S', 'S']
      : ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
}

String _dateKey(DateTime date) {
  final y = date.year.toString().padLeft(4, '0');
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
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

String _timeLabel(int hour) {
  final displayHour =
      hour == 0 ? 12 : hour > 12 ? hour - 12 : hour;

  final period = hour < 12 ? 'AM' : 'PM';

  return '$displayHour $period';
}
