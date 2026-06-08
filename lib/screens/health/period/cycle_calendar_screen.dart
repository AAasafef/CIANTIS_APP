import 'package:flutter/material.dart';

class CycleCalendarScreen extends StatefulWidget {
  const CycleCalendarScreen({super.key});

  @override
  State<CycleCalendarScreen> createState() =>
      _CycleCalendarScreenState();
}

class _CycleCalendarScreenState extends State<CycleCalendarScreen> {
  DateTime selectedDate = DateTime.now();

  final DateTime periodStart = DateTime(2024, 5, 12);
  final DateTime periodEnd = DateTime(2024, 5, 17);
  final DateTime nextPredicted = DateTime(2024, 6, 9);

  void _previousMonth() {
    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month + 1,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = _monthGridDays(selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                title: 'Calendar',
                subtitle: 'CYCLE VIEW',
                onBack: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _SmallIconButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: _previousMonth,
                  ),
                  Expanded(
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
                  _SmallIconButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: _nextMonth,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 410,
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 14),
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    Row(
                      children: _weekdayLabels().map((label) {
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
                    const SizedBox(height: 12),
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: days.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisExtent: 48,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemBuilder: (context, index) {
                          final date = days[index];
                          final currentMonth =
                              date.month == selectedDate.month;
                          final today = _isSameDay(date, DateTime.now());
                          final periodDay = !date.isBefore(periodStart) &&
                              !date.isAfter(periodEnd);
                          final predictedDay =
                              date.year == nextPredicted.year &&
                                  date.month == nextPredicted.month &&
                                  date.day >= nextPredicted.day &&
                                  date.day <= nextPredicted.day + 4;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: periodDay
                                    ? const Color(0xFFB78A7E)
                                    : predictedDay
                                        ? const Color(0xFFE6DDD2)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                                border: today
                                    ? Border.all(
                                        color: const Color(0xFFC6A06B),
                                        width: 1.3,
                                      )
                                    : null,
                              ),
                              child: Text(
                                '${date.day}',
                                style: TextStyle(
                                  color: periodDay
                                      ? const Color(0xFFFFF9F1)
                                      : currentMonth
                                          ? const Color(0xFF241D18)
                                          : const Color(0xFFC5B9AE),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _LegendDot(
                          color: Color(0xFFB78A7E),
                          label: 'Period',
                        ),
                        SizedBox(width: 18),
                        _LegendDot(
                          color: Color(0xFFE6DDD2),
                          label: 'Predicted',
                        ),
                        SizedBox(width: 18),
                        _LegendRing(label: 'Today'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const _Header({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SmallIconButton(
          icon: Icons.chevron_left_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 42,
                  height: .95,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.4,
                  color: Color(0xFF241D18),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3,
                  color: Color(0xFF8B7D72),
                ),
              ),
            ],
          ),
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
          color: const Color(0xFFFBF8F4).withOpacity(.9),
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

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 9,
          width: 9,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6F6258),
            fontSize: 11,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class _LegendRing extends StatelessWidget {
  final String label;

  const _LegendRing({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFC6A06B),
              width: 1,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6F6258),
            fontSize: 11,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: const Color(0xFFFBF8F4).withOpacity(.9),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: const Color(0xFFE2D8CD),
      width: .7,
    ),
  );
}

List<DateTime> _monthGridDays(DateTime selectedDate) {
  final first = DateTime(selectedDate.year, selectedDate.month, 1);
  final leading = first.weekday % 7;
  final start = first.subtract(Duration(days: leading));

  return List.generate(
    42,
    (index) => start.add(Duration(days: index)),
  );
}

List<String> _weekdayLabels() {
  return ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
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