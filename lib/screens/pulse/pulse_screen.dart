import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../models/life_analytics_entry.dart';
import '../../models/life_milestone_entry.dart';
import '../../services/life_analytics_service.dart';
import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../calendar/calendar_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

class PulseScreen extends StatefulWidget {
  const PulseScreen({super.key});

  @override
  State<PulseScreen> createState() => _PulseScreenState();
}

class _PulseScreenState extends State<PulseScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final ScrollController _scrollController = ScrollController();

  bool _showBottomNav = true;
  bool _loading = true;

  List<LifeAnalyticsEntry> _entries = [];
  List<LifeMilestoneEntry> _milestones = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _loadPulseData();

    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;

      if (direction.toString().contains('reverse') && _showBottomNav) {
        setState(() => _showBottomNav = false);
      }

      if (direction.toString().contains('forward') && !_showBottomNav) {
        setState(() => _showBottomNav = true);
      }
    });
  }

  Future<void> _loadPulseData() async {
    final entries = await LifeAnalyticsService.getEntries();
    final milestones = await LifeAnalyticsService.getMilestones();

    if (!mounted) return;

    setState(() {
      _entries = entries;
      _milestones = milestones;
      _loading = false;
    });
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

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CiantisSideDrawer(),
      extendBody: true,
      backgroundColor: const Color(0xFFF4EFE8),
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        offset: _showBottomNav ? Offset.zero : const Offset(0, 1.25),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: _showBottomNav ? 1 : 0,
          child: SpacesBottomNavBar(
            currentIndex: 2,
            onTap: _handleBottomNavTap,
          ),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2D241D),
              ),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFF8F4EE),
                          Color(0xFFEFE5DA),
                          Color(0xFFE4D6C7),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PulseHeader(
                        onRefresh: _loadPulseData,
                      ),
                      _PulseTabs(tabController: _tabController),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _PulseOverviewTab(
                              entries: _entries,
                              milestones: _milestones,
                              scrollController: _scrollController,
                            ),
                            _PulseTimelineTab(
                              milestones: _milestones,
                            ),
                            _PulsePatternsTab(
                              entries: _entries,
                            ),
                            _PulseInsightsTab(
                              entries: _entries,
                              milestones: _milestones,
                            ),
                          ],
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

class _PulseHeader extends StatelessWidget {
  final VoidCallback onRefresh;

  const _PulseHeader({
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF8F4).withOpacity(.88),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE2D8CD),
                      width: .7,
                    ),
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: Color(0xFF241D18),
                    size: 23,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pulse',
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
                  'LIFE PATTERNS & TIMELINE',
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
          GestureDetector(
            onTap: onRefresh,
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFFBF8F4).withOpacity(.88),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE2D8CD),
                  width: .7,
                ),
              ),
              child: const Icon(
                Icons.refresh_rounded,
                color: Color(0xFF241D18),
                size: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseTabs extends StatelessWidget {
  final TabController tabController;

  const _PulseTabs({
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.fromLTRB(24, 8, 24, 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: TabBar(
        controller: tabController,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: const Color(0xFF241D18),
          borderRadius: BorderRadius.circular(14),
        ),
        labelColor: const Color(0xFFFFF9F1),
        unselectedLabelColor: const Color(0xFF6F6258),
        labelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w300,
          letterSpacing: .4,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w300,
          letterSpacing: .4,
        ),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Timeline'),
          Tab(text: 'Patterns'),
          Tab(text: 'Insights'),
        ],
      ),
    );
  }
}

class _PulseOverviewTab extends StatelessWidget {
  final List<LifeAnalyticsEntry> entries;
  final List<LifeMilestoneEntry> milestones;
  final ScrollController scrollController;

  const _PulseOverviewTab({
    required this.entries,
    required this.milestones,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final todayCount = _todayEntries(entries).length;
    final moodCount = entries.where((entry) => entry.type == 'mood').length;
    final journalCount =
        entries.where((entry) => entry.type == 'journal').length;

    return ListView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 140),
      children: [
        _HeroPulseCard(
          todayCount: todayCount,
          totalCount: entries.length,
          milestoneCount: milestones.length,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _PulseStatCard(
                value: todayCount.toString(),
                label: 'Today',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _PulseStatCard(
                value: moodCount.toString(),
                label: 'Mood',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _PulseStatCard(
                value: journalCount.toString(),
                label: 'Journal',
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        const _PulseSectionTitle(title: 'Recent Signals'),
        const SizedBox(height: 12),
        if (entries.isEmpty)
          const _SoftInfoCard(
            text:
                'No signals yet. Journal entries, mood check-ins, cycle notes, habits, prayers, and milestones will collect here.',
          )
        else
          ...entries.reversed.take(5).map((entry) {
            return _SignalTile(entry: entry);
          }),
        const SizedBox(height: 26),
        const _PulseSectionTitle(title: 'Timeline Preview'),
        const SizedBox(height: 12),
        _MiniTimelinePreview(milestones: milestones),
      ],
    );
  }
}

class _HeroPulseCard extends StatelessWidget {
  final int todayCount;
  final int totalCount;
  final int milestoneCount;

  const _HeroPulseCard({
    required this.todayCount,
    required this.totalCount,
    required this.milestoneCount,
  });

  @override
  Widget build(BuildContext context) {
    final hasData = totalCount > 0 || milestoneCount > 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF241D18),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today’s Pulse',
            style: TextStyle(
              color: Color(0xFFF8F4EE),
              fontSize: 26,
              fontWeight: FontWeight.w300,
              letterSpacing: -.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            hasData
                ? '$todayCount signals logged today. Your story is collecting quietly.'
                : 'Your life data will appear here once your check-ins, journal entries, and milestones begin flowing in.',
            style: TextStyle(
              color: Colors.white.withOpacity(.78),
              fontSize: 14,
              height: 1.55,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _HeroMiniNumber(
                value: totalCount.toString(),
                label: 'Signals',
              ),
              const SizedBox(width: 22),
              _HeroMiniNumber(
                value: milestoneCount.toString(),
                label: 'Milestones',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroMiniNumber extends StatelessWidget {
  final String value;
  final String label;

  const _HeroMiniNumber({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFC6A06B),
            fontSize: 30,
            fontWeight: FontWeight.w300,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.white.withOpacity(.55),
            fontSize: 9,
            letterSpacing: 2.2,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class _PulseTimelineTab extends StatefulWidget {
  final List<LifeMilestoneEntry> milestones;

  const _PulseTimelineTab({
    required this.milestones,
  });

  @override
  State<_PulseTimelineTab> createState() => _PulseTimelineTabState();
}

class _PulseTimelineTabState extends State<_PulseTimelineTab> {
  final ScrollController _yearController = ScrollController();

  int _selectedYear = 1993;

  final int _startYear = 1993;
  final int _endYear = DateTime.now().year;
  final double _yearWidth = 118;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToYear(1993);
    });
  }

  void _scrollToYear(int year) {
    if (!_yearController.hasClients) return;

    final index = year - _startYear + 1;
    final target = (index * _yearWidth) -
        (MediaQuery.of(context).size.width / 2) +
        (_yearWidth / 2);

    _yearController.animateTo(
      target.clamp(
        _yearController.position.minScrollExtent,
        _yearController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  List<_PulseTimelineMoment> get _moments {
    final moments = <_PulseTimelineMoment>[
      _PulseTimelineMoment.before(),
      _PulseTimelineMoment.birth(),
    ];

    for (final milestone in widget.milestones) {
      moments.add(
        _PulseTimelineMoment(
          id: milestone.id,
          year: milestone.date.year,
          title: milestone.title,
          subtitle: milestone.category,
          date: milestone.date,
          category: milestone.category,
          note: milestone.note,
          isBirth: false,
          isBefore: false,
        ),
      );
    }

    return moments;
  }

  @override
  Widget build(BuildContext context) {
    final moments = _moments;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0, .16, .36, 1],
                colors: [
                  Color(0xFFD8C7B5),
                  Color(0xFFE9DDD0),
                  Color(0xFFF4EFE8),
                  Color(0xFFF8F4EE),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _SoftBackgroundPainter(),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 18),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Timeline',
                    style: TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 34,
                      height: 1,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  _selectedYear == 1993
                      ? 'A beautiful beginning.'
                      : 'Scroll across the years. Details will deepen as Pulse grows.',
                  style: TextStyle(
                    color: const Color(0xFF6F6258).withOpacity(.86),
                    fontSize: 13,
                    height: 1.4,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 210,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      final center = _yearController.offset +
                          (MediaQuery.of(context).size.width / 2);

                      final index = (center / _yearWidth).round();
                      final year = (_startYear + index - 1)
                          .clamp(_startYear, _endYear);

                      if (year != _selectedYear) {
                        setState(() {
                          _selectedYear = year;
                        });
                      }
                    }

                    return false;
                  },
                  child: ListView.builder(
                    controller: _yearController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 2 -
                          (_yearWidth / 2),
                    ),
                    itemCount: (_endYear - _startYear) + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return SizedBox(
                          width: _yearWidth,
                          child: _BeforeTimelineMarker(
                            onTap: _openBeforeSheet,
                          ),
                        );
                      }

                      final year = _startYear + index - 1;
                      final yearMoments =
                          moments.where((m) => m.year == year).toList();

                      return SizedBox(
                        width: _yearWidth,
                        child: _YearTimelineMarker(
                          year: year,
                          selected: year == _selectedYear,
                          moments: yearMoments,
                          onTap: () {
                            final birth =
                                yearMoments.where((m) => m.isBirth).toList();

                            if (birth.isNotEmpty) {
                              _openBirthSheet();
                              return;
                            }

                            if (yearMoments.isNotEmpty) {
                              _openYearMoments(year, yearMoments);
                              return;
                            }

                            _scrollToYear(year);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 134),
                child: _TimelineHintCard(
                  selectedYear: _selectedYear,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openBeforeSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _BeforeStorySheet(),
    );
  }

  void _openBirthSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _BirthStorySheet(),
    );
  }

  void _openYearMoments(int year, List<_PulseTimelineMoment> moments) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _YearMomentsSheet(
        year: year,
        moments: moments,
      ),
    );
  }
}

class _BeforeTimelineMarker extends StatelessWidget {
  final VoidCallback onTap;

  const _BeforeTimelineMarker({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Before',
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 14,
              fontWeight: FontWeight.w300,
              letterSpacing: .8,
            ),
          ),
          SizedBox(height: 22),
          _TimelineDot(
            color: Color(0xFF9E8E80),
            size: 8,
          ),
          SizedBox(height: 22),
          Text(
            'Known',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 10,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _YearTimelineMarker extends StatelessWidget {
  final int year;
  final bool selected;
  final List<_PulseTimelineMoment> moments;
  final VoidCallback onTap;

  const _YearTimelineMarker({
    required this.year,
    required this.selected,
    required this.moments,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isBirthYear = year == 1993;
    final hasMoments = moments.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 220),
            style: TextStyle(
              color: selected
                  ? const Color(0xFF241D18)
                  : const Color(0xFF8B7D72),
              fontSize: selected ? 22 : 15,
              fontWeight: FontWeight.w300,
              letterSpacing: selected ? -.2 : .6,
            ),
            child: Text('$year'),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              if (isBirthYear)
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: .8, end: 1.25),
                  duration: const Duration(milliseconds: 1400),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Container(
                      height: 38 * value,
                      width: 38 * value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFC6A06B).withOpacity(.12),
                      ),
                    );
                  },
                ),
              _TimelineDot(
                color: isBirthYear
                    ? const Color(0xFFC6A06B)
                    : hasMoments
                        ? const Color(0xFF241D18)
                        : const Color(0xFFB9ADA3),
                size: isBirthYear ? 17 : hasMoments ? 11 : 7,
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 32,
            child: Text(
              isBirthYear
                  ? 'A Beautiful\nBeginning'
                  : hasMoments
                      ? '${moments.length} moment${moments.length == 1 ? '' : 's'}'
                      : '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isBirthYear
                    ? const Color(0xFF6E5846)
                    : const Color(0xFF8B7D72),
                fontSize: isBirthYear ? 10 : 9,
                height: 1.2,
                letterSpacing: isBirthYear ? 1.2 : .8,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineDot extends StatelessWidget {
  final Color color;
  final double size;

  const _TimelineDot({
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.35),
            blurRadius: size * 1.4,
            spreadRadius: size * .25,
          ),
        ],
      ),
    );
  }
}

class _TimelineHintCard extends StatelessWidget {
  final int selectedYear;

  const _TimelineHintCard({
    required this.selectedYear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.74),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Text(
        selectedYear == 1993
            ? 'Tap 1993 to open the first page of your story.'
            : 'Future zoom: years become months, months become moments.',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF6F6258),
          fontSize: 13,
          fontWeight: FontWeight.w300,
          height: 1.45,
        ),
      ),
    );
  }
}

class _BirthStorySheet extends StatelessWidget {
  const _BirthStorySheet();

  @override
  Widget build(BuildContext context) {
    return _LuxurySheetFrame(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 34),
        shrinkWrap: true,
        children: const [
          Text(
            'A Beautiful Beginning',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 36,
              height: 1,
              fontWeight: FontWeight.w300,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Saturday • April 17, 1993 • 12:00 PM',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 11,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.1,
            ),
          ),
          SizedBox(height: 26),
          _DetailPair(
            title: 'Place',
            value: 'Shands Hospital\nGainesville, Florida',
          ),
          _DetailPair(
            title: 'Birth Weight',
            value: '6 lb 7 oz',
          ),
          _DetailPair(
            title: 'Born To',
            value: 'Vanessa Cooper\nHenry Crosby',
          ),
          SizedBox(height: 10),
          _PoeticBlock(
            text:
                'A baby girl arrived with a full head of hair and a presence that made the room feel different.\n\nA Saturday afternoon wrapped in grace. A beautiful day. The kind of day heaven remembers.\n\nAngels were definitely present. The enemy was too, but he does not matter here.\n\nThis was the beginning of a story that was never random, never ordinary, and never without purpose.',
          ),
        ],
      ),
    );
  }
}

class _BeforeStorySheet extends StatelessWidget {
  const _BeforeStorySheet();

  @override
  Widget build(BuildContext context) {
    return _LuxurySheetFrame(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 34),
        shrinkWrap: true,
        children: const [
          Text(
            'Before',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 38,
              height: 1,
              fontWeight: FontWeight.w300,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'THE QUIET PLACE BEFORE THE TIMELINE',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 10,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.4,
            ),
          ),
          SizedBox(height: 28),
          _PoeticBlock(
            text:
                'Before the first breath, before the first step, before the first memory, you were already known.\n\nHeld in thought. Formed with intention. Created with care.\n\nNot rushed. Not overlooked. Not accidental.\n\nA life prepared before the world ever saw your face.',
          ),
        ],
      ),
    );
  }
}

class _YearMomentsSheet extends StatelessWidget {
  final int year;
  final List<_PulseTimelineMoment> moments;

  const _YearMomentsSheet({
    required this.year,
    required this.moments,
  });

  @override
  Widget build(BuildContext context) {
    return _LuxurySheetFrame(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 34),
        shrinkWrap: true,
        children: [
          Text(
            '$year',
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 38,
              height: 1,
              fontWeight: FontWeight.w300,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'TIMELINE MOMENTS',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 10,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.4,
            ),
          ),
          const SizedBox(height: 24),
          ...moments.map((moment) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF8F4),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFE2D8CD),
                  width: .7,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    moment.title,
                    style: const TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${moment.category} • ${_dateText(moment.date)}',
                    style: const TextStyle(
                      color: Color(0xFF8B7D72),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  if (moment.note != null &&
                      moment.note!.trim().isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      moment.note!,
                      style: const TextStyle(
                        color: Color(0xFF6F6258),
                        fontSize: 13,
                        height: 1.45,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _LuxurySheetFrame extends StatelessWidget {
  final Widget child;

  const _LuxurySheetFrame({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .86,
      ),
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFE8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFFD8C7B5),
          width: .8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.12),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _DetailPair extends StatelessWidget {
  final String title;
  final String value;

  const _DetailPair({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 10,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.2,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 20,
              height: 1.25,
              fontWeight: FontWeight.w300,
              letterSpacing: -.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _PoeticBlock extends StatelessWidget {
  final String text;

  const _PoeticBlock({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF3A2E26),
        fontSize: 17,
        height: 1.62,
        fontWeight: FontWeight.w300,
        letterSpacing: -.1,
      ),
    );
  }
}

class _PulsePatternsTab extends StatelessWidget {
  final List<LifeAnalyticsEntry> entries;

  const _PulsePatternsTab({
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    final moodEntries = entries.where((entry) => entry.type == 'mood').toList();
    final journalEntries =
        entries.where((entry) => entry.type == 'journal').toList();
    final periodEntries =
        entries.where((entry) => entry.type == 'period_symptom').toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 140),
      children: [
        const _PulseSectionTitle(title: 'Pattern View'),
        const SizedBox(height: 12),
        _PatternGraphCard(
          title: 'Mood',
          entries: moodEntries,
        ),
        const SizedBox(height: 16),
        _PatternGraphCard(
          title: 'Journal',
          entries: journalEntries,
        ),
        const SizedBox(height: 16),
        _PatternGraphCard(
          title: 'Cycle',
          entries: periodEntries,
        ),
      ],
    );
  }
}

class _PatternGraphCard extends StatelessWidget {
  final String title;
  final List<LifeAnalyticsEntry> entries;

  const _PatternGraphCard({
    required this.title,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 218,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.88),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: entries.length < 2
          ? Center(
              child: Text(
                'Need more $title data to reveal a pattern.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF8B7D72),
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          : CustomPaint(
              painter: _PulseLinePainter(entries),
              child: const SizedBox.expand(),
            ),
    );
  }
}

class _PulseInsightsTab extends StatelessWidget {
  final List<LifeAnalyticsEntry> entries;
  final List<LifeMilestoneEntry> milestones;

  const _PulseInsightsTab({
    required this.entries,
    required this.milestones,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 140),
      children: [
        const _PulseSectionTitle(title: 'Insights'),
        const SizedBox(height: 12),
        _InsightCard(
          title: 'Your data is beginning to form.',
          body:
              'Pulse will study your check-ins, journals, symptoms, prayers, milestones, and goals to show repeated patterns over time.',
          icon: Icons.auto_awesome_outlined,
        ),
        const SizedBox(height: 12),
        _InsightCard(
          title: 'Timeline foundation ready.',
          body:
              'The timeline begins before 1993, honors your birth year, and grows as milestones are saved.',
          icon: Icons.timeline_rounded,
        ),
        const SizedBox(height: 12),
        _InsightCard(
          title: 'More connections coming.',
          body:
              'Mood, cycle, health, academy, treasury, prayer, and horizons can each feed Pulse as those screens are connected.',
          icon: Icons.hub_outlined,
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;

  const _InsightCard({
    required this.title,
    required this.body,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.88),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF6E5846),
            size: 24,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: const TextStyle(
                    color: Color(0xFF6F6258),
                    fontSize: 12.5,
                    height: 1.45,
                    fontWeight: FontWeight.w300,
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

class _PulseSectionTitle extends StatelessWidget {
  final String title;

  const _PulseSectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF241D18),
        fontSize: 20,
        fontWeight: FontWeight.w300,
        letterSpacing: -.3,
      ),
    );
  }
}

class _PulseStatCard extends StatelessWidget {
  final String value;
  final String label;

  const _PulseStatCard({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 15, 14, 13),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.88),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 24,
              height: 1,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 9,
              letterSpacing: 2,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _SignalTile extends StatelessWidget {
  final LifeAnalyticsEntry entry;

  const _SignalTile({
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.88),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _entryIcon(entry.type),
            color: const Color(0xFF6E5846),
            size: 22,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${entry.source} • ${_dateText(entry.date)}',
                  style: const TextStyle(
                    color: Color(0xFF8B7D72),
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
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

class _SoftInfoCard extends StatelessWidget {
  final String text;

  const _SoftInfoCard({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.88),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF6F6258),
          fontSize: 13,
          height: 1.5,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class _MiniTimelinePreview extends StatelessWidget {
  final List<LifeMilestoneEntry> milestones;

  const _MiniTimelinePreview({
    required this.milestones,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4).withOpacity(.88),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Before',
            style: TextStyle(
              color: Color(0xFF8B7D72),
              fontSize: 11,
              fontWeight: FontWeight.w300,
            ),
          ),
          Expanded(
            child: Container(
              height: .8,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: const Color(0xFFCBBBAA),
            ),
          ),
          const _TimelineDot(
            color: Color(0xFFC6A06B),
            size: 14,
          ),
          Expanded(
            child: Container(
              height: .8,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: Color(0xFFCBBBAA),
            ),
          ),
          Text(
            '${DateTime.now().year}',
            style: const TextStyle(
              color: Color(0xFF241D18),
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseTimelineMoment {
  final String id;
  final int year;
  final String title;
  final String subtitle;
  final DateTime date;
  final String category;
  final String? note;
  final bool isBirth;
  final bool isBefore;

  const _PulseTimelineMoment({
    required this.id,
    required this.year,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.category,
    this.note,
    required this.isBirth,
    required this.isBefore,
  });

  factory _PulseTimelineMoment.before() {
    return _PulseTimelineMoment(
      id: 'before',
      year: 1992,
      title: 'Before',
      subtitle: 'You were known.',
      date: DateTime(1992),
      category: 'Origin',
      note: 'Before your first breath, you were known.',
      isBirth: false,
      isBefore: true,
    );
  }

  factory _PulseTimelineMoment.birth() {
    return _PulseTimelineMoment(
      id: 'birth_1993',
      year: 1993,
      title: 'A Beautiful Beginning',
      subtitle: 'April 17, 1993',
      date: DateTime(1993, 4, 17, 12),
      category: 'Origin',
      note: 'Born at Shands Hospital in Gainesville, Florida.',
      isBirth: true,
      isBefore: false,
    );
  }
}

class _PulseLinePainter extends CustomPainter {
  final List<LifeAnalyticsEntry> entries;

  _PulseLinePainter(this.entries);

  @override
  void paint(Canvas canvas, Size size) {
    if (entries.length < 2) return;

    final sorted = [...entries]..sort((a, b) => a.date.compareTo(b.date));
    final values = sorted.map((entry) => entry.value).toList();

    final min = values.reduce(math.min);
    final max = values.reduce(math.max);
    final range = max - min == 0 ? 1 : max - min;

    final gridPaint = Paint()
      ..color = const Color(0xFFE2D8CD)
      ..strokeWidth = .7;

    final linePaint = Paint()
      ..color = const Color(0xFF6E5846)
      ..strokeWidth = 2.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = const Color(0xFF6E5846).withOpacity(.08)
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = const Color(0xFF241D18)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 4; i++) {
      final y = size.height * (i / 3);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    final path = Path();
    final fillPath = Path();

    for (int i = 0; i < sorted.length; i++) {
      final x = size.width * (i / (sorted.length - 1));
      final y = size.height -
          (((sorted[i].value - min) / range) * size.height);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      canvas.drawCircle(Offset(x, y), 3.6, dotPaint);
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _SoftBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFBBAA99).withOpacity(.52)
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round;

    final y = size.height / 2;

    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      linePaint,
    );

    final glowPaint = Paint()
      ..color = const Color(0xFFC6A06B).withOpacity(.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    canvas.drawCircle(
      Offset(size.width * .24, y),
      80,
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

List<LifeAnalyticsEntry> _todayEntries(List<LifeAnalyticsEntry> entries) {
  final now = DateTime.now();

  return entries.where((entry) {
    return entry.date.year == now.year &&
        entry.date.month == now.month &&
        entry.date.day == now.day;
  }).toList();
}

String _dateText(DateTime date) {
  return '${date.month}/${date.day}/${date.year}';
}

IconData _entryIcon(String type) {
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
