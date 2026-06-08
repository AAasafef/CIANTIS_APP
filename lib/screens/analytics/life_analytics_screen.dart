import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/life_analytics_entry.dart';
import '../../models/life_milestone_entry.dart';
import '../../services/life_analytics_service.dart';

class LifeAnalyticsScreen extends StatefulWidget {
  const LifeAnalyticsScreen({super.key});

  @override
  State<LifeAnalyticsScreen> createState() => _LifeAnalyticsScreenState();
}

class _LifeAnalyticsScreenState extends State<LifeAnalyticsScreen> {
  List<LifeAnalyticsEntry> entries = [];
  List<LifeMilestoneEntry> milestones = [];

  bool loading = true;
  String selectedType = 'journal';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final loadedEntries = await LifeAnalyticsService.getEntries();
    final loadedMilestones = await LifeAnalyticsService.getMilestones();

    if (!mounted) return;

    setState(() {
      entries = loadedEntries;
      milestones = loadedMilestones;
      loading = false;

      if (trackedTypes.isNotEmpty && !trackedTypes.contains(selectedType)) {
        selectedType = trackedTypes.first;
      }
    });
  }

  List<LifeAnalyticsEntry> get todayEntries {
    final now = DateTime.now();

    return entries.where((entry) {
      return entry.date.year == now.year &&
          entry.date.month == now.month &&
          entry.date.day == now.day;
    }).toList();
  }

  List<String> get trackedTypes {
    final types = entries.map((entry) => entry.type).toSet().toList();

    const preferred = [
      'mood',
      'period_symptom',
      'journal',
      'habit',
      'water',
      'steps',
      'weight',
      'prayer',
      'school',
      'work',
    ];

    final ordered = <String>[];

    for (final item in preferred) {
      if (types.contains(item)) ordered.add(item);
    }

    for (final item in types) {
      if (!ordered.contains(item)) ordered.add(item);
    }

    return ordered.isEmpty ? ['journal', 'mood', 'period_symptom'] : ordered;
  }

  List<LifeAnalyticsEntry> entriesForType(String type) {
    return entries.where((entry) => entry.type == type).toList();
  }

  double averageForType(String type) {
    final items = entriesForType(type);

    if (items.isEmpty) return 0;

    final total = items.fold<double>(
      0,
      (sum, entry) => sum + entry.value,
    );

    return total / items.length;
  }

  @override
  Widget build(BuildContext context) {
    final selectedEntries = entriesForType(selectedType);

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF74624F),
                ),
              )
            : RefreshIndicator(
                onRefresh: _loadData,
                color: const Color(0xFF74624F),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(22, 18, 22, 36),
                  children: [
                    _header(),
                    const SizedBox(height: 18),
                    _dailyAssignmentCard(),
                    const SizedBox(height: 14),
                    _statRow(),
                    const SizedBox(height: 26),
                    _sectionTitle('Behavior Pattern'),
                    const SizedBox(height: 12),
                    _typeFilter(),
                    const SizedBox(height: 12),
                    _lineChartCard(selectedEntries),
                    const SizedBox(height: 26),
                    _sectionTitle('Today’s Data'),
                    const SizedBox(height: 12),
                    _todayDataCard(),
                    const SizedBox(height: 26),
                    _sectionTitle('Life Timeline'),
                    const SizedBox(height: 12),
                    _timelineCard(),
                    const SizedBox(height: 26),
                    _sectionTitle('Connected Sources'),
                    const SizedBox(height: 12),
                    _sourcesCard(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
            color: Color(0xFF2D241E),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Life Analytics',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 36,
              fontWeight: FontWeight.w400,
              height: 1,
              color: const Color(0xFF2D241E),
            ),
          ),
        ),
        GestureDetector(
          onTap: _loadData,
          child: Container(
            height: 42,
            width: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFF8F2EA),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF74624F),
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dailyAssignmentCard() {
    final completed = todayEntries.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF2D241E),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: completed
                  ? const Color(0xFFB7C7A3)
                  : const Color(0xFFD8CEC4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              completed
                  ? Icons.check_rounded
                  : Icons.assignment_turned_in_outlined,
              color: const Color(0xFF2D241E),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Data Assignment',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFF8F2EA),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  completed
                      ? '${todayEntries.length} item${todayEntries.length == 1 ? '' : 's'} logged today.'
                      : 'Nothing logged today. Journal, mood, cycle, habits, and wellness data will collect here.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFD8CEC4),
                    fontSize: 12.5,
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

  Widget _statRow() {
    return Row(
      children: [
        Expanded(
          child: _miniStat(
            title: 'Today',
            value: todayEntries.length.toString(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _miniStat(
            title: 'Total',
            value: entries.length.toString(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _miniStat(
            title: 'Timeline',
            value: milestones.length.toString(),
          ),
        ),
      ],
    );
  }

  Widget _miniStat({
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 15, 14, 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD8CEC4),
          width: .7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 21,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2D241E),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFF84776C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF2D241E),
      ),
    );
  }

  Widget _typeFilter() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: trackedTypes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final type = trackedTypes[index];
          final selected = selectedType == type;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedType = type;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF74624F)
                    : const Color(0xFFF8F2EA),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF74624F)
                      : const Color(0xFFD8CEC4),
                  width: .7,
                ),
              ),
              child: Text(
                _pretty(type),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF6F6258),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _lineChartCard(List<LifeAnalyticsEntry> chartEntries) {
    return Container(
      height: 230,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EA),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFD8CEC4),
          width: .7,
        ),
      ),
      child: chartEntries.length < 2
          ? Center(
              child: Text(
                chartEntries.isEmpty
                    ? 'No ${_pretty(selectedType).toLowerCase()} data yet.'
                    : 'Need at least 2 entries to draw the line.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF84776C),
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            )
          : CustomPaint(
              painter: _AnalyticsLinePainter(chartEntries),
              child: const SizedBox.expand(),
            ),
    );
  }

  Widget _todayDataCard() {
    if (todayEntries.isEmpty) {
      return _emptyCard(
        'No data logged today yet. Once you save something in Journal or other trackers, it will show here.',
      );
    }

    final sorted = [...todayEntries]..sort((a, b) => b.date.compareTo(a.date));

    return Column(
      children: sorted.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F2EA),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFD8CEC4),
              width: .7,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _iconForType(entry.type),
                color: const Color(0xFF74624F),
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF2D241E),
                  ),
                ),
              ),
              Text(
                _pretty(entry.type),
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0xFF84776C),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _timelineCard() {
    if (milestones.isEmpty) {
      return _emptyCard(
        'Prayer dates, answered prayers, school milestones, work events, goal wins, and life history will show here once added.',
      );
    }

    final sorted = [...milestones]..sort((a, b) => b.date.compareTo(a.date));

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EA),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFD8CEC4),
          width: .7,
        ),
      ),
      child: Column(
        children: sorted.map((item) {
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF74624F),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 1,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        color: const Color(0xFFD8CEC4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: GoogleFonts.inter(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2D241E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.category} • ${_date(item.date)}',
                          style: GoogleFonts.inter(
                            fontSize: 11.5,
                            color: const Color(0xFF84776C),
                          ),
                        ),
                        if (item.answeredDate != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Answered ${_date(item.answeredDate!)} • ${item.daysToAnswer} days',
                            style: GoogleFonts.inter(
                              fontSize: 11.5,
                              color: const Color(0xFF74624F),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _sourcesCard() {
    final counts = <String, int>{};

    for (final entry in entries) {
      counts[entry.source] = (counts[entry.source] ?? 0) + 1;
    }

    if (counts.isEmpty) {
      return _emptyCard(
        'No connected sources yet. Journal is connected now. Mood, Cycle, Habits, Water, Steps, Weight, and Prayer can connect next.',
      );
    }

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      children: sorted.map((source) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F2EA),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFD8CEC4),
              width: .7,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  source.key.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    letterSpacing: 1.2,
                    color: const Color(0xFF6F6258),
                  ),
                ),
              ),
              Text(
                source.value.toString(),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF2D241E),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _emptyCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2EA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD8CEC4),
          width: .7,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 12.5,
          height: 1.45,
          color: const Color(0xFF84776C),
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'mood':
        return Icons.mood_outlined;
      case 'period_symptom':
        return Icons.water_drop_outlined;
      case 'journal':
        return Icons.menu_book_outlined;
      case 'habit':
        return Icons.check_circle_outline;
      case 'water':
        return Icons.local_drink_outlined;
      case 'steps':
        return Icons.directions_walk_rounded;
      case 'weight':
        return Icons.monitor_weight_outlined;
      case 'prayer':
        return Icons.auto_awesome_outlined;
      default:
        return Icons.insights_outlined;
    }
  }

  String _pretty(String value) {
    return value
        .replaceAll('_', ' ')
        .split(' ')
        .where((word) => word.trim().isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _date(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

class _AnalyticsLinePainter extends CustomPainter {
  final List<LifeAnalyticsEntry> entries;

  _AnalyticsLinePainter(this.entries);

  @override
  void paint(Canvas canvas, Size size) {
    final sorted = [...entries]..sort((a, b) => a.date.compareTo(b.date));

    if (sorted.length < 2) return;

    final values = sorted.map((entry) => entry.value).toList();
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final range = max - min == 0 ? 1 : max - min;

    final gridPaint = Paint()
      ..color = const Color(0xFFD8CEC4)
      ..strokeWidth = .7;

    final linePaint = Paint()
      ..color = const Color(0xFF74624F)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = const Color(0xFF74624F).withOpacity(.10)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = const Color(0xFF2D241E)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 4; i++) {
      final y = size.height * (i / 3);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final path = Path();
    final fillPath = Path();

    for (int i = 0; i < sorted.length; i++) {
      final x = size.width * (i / (sorted.length - 1));
      final normalized = (sorted[i].value - min) / range;
      final y = size.height - (normalized * size.height);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}