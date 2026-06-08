import 'package:flutter/material.dart';

import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../../services/notification_service.dart';

import '../activity/activity_screen.dart';
import '../calendar/calendar_screen.dart';
import '../notifications/notifications_screen.dart';
import '../search/global_search_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

import 'daily_devotional_screen.dart';
import 'daily_devotional_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController scrollController =
      ScrollController();

  bool showBottomNav = true;

  final List<String> dailyImages = const [
    'assets/images/spaces/family.jpg',
    'assets/images/spaces/school.jpg',
    'assets/images/spaces/work.jpg',
    'assets/images/spaces/library.jpg',
    'assets/images/spaces/health.jpg',
    'assets/images/spaces/money.jpg',
    'assets/images/spaces/documents.jpg',
  ];

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

  String getDailyImage() {
    final now = DateTime.now();
    final start = DateTime(now.year, 1, 1);
    final day = now.difference(start).inDays;

    return dailyImages[day % dailyImages.length];
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
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CiantisSideDrawer(),
      extendBody: true,
      backgroundColor: const Color(0xFFF4EFE8),
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              getDailyImage(),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE8DED1),
                );
              },
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.05),
                    Colors.black.withOpacity(.14),
                    Colors.black.withOpacity(.52),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                24,
                18,
                24,
                132,
              ),
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height - 190,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    _TopOverlayBar(
                      onSearchTap: () {
                        _openScreen(
                          const GlobalSearchScreen(),
                        );
                      },
                      onActivityTap: () {
                        _openScreen(
                          const ActivityScreen(),
                        );
                      },
                      onNotificationsTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const NotificationsScreen(),
                          ),
                        );

                        if (mounted) {
                          setState(() {});
                        }
                      },
                    ),

                    const SizedBox(height: 18),

                    if (NotificationService
                            .instance.unreadCount >
                        0)
                      _NotificationFloatCard(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const NotificationsScreen(),
                            ),
                          );

                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),

                    const Spacer(),

                    FutureBuilder<DailyDevotional>(
                      future: DailyDevotionalService
                          .getTodayDevotional(),
                      builder: (context, snapshot) {
                        final devotional = snapshot.data;

                        return _SubtleDevotionalText(
                          reference:
                              devotional?.reference ??
                                  'Psalm 46:10',
                          verse: devotional?.verse ??
                              'Be still, and know that I am God.',
                          onReadMore: () {
                            _openScreen(
                              const DailyDevotionalScreen(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopOverlayBar extends StatelessWidget {
  final VoidCallback onSearchTap;
  final VoidCallback onActivityTap;
  final VoidCallback onNotificationsTap;

  const _TopOverlayBar({
    required this.onSearchTap,
    required this.onActivityTap,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Ciantis',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              height: .95,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.5,
            ),
          ),
        ),

        _GlassIconButton(
          icon: Icons.search_rounded,
          onTap: onSearchTap,
        ),

        const SizedBox(width: 9),

        _GlassIconButton(
          icon: Icons.timeline_rounded,
          onTap: onActivityTap,
        ),

        const SizedBox(width: 9),

        Stack(
          clipBehavior: Clip.none,
          children: [
            _GlassIconButton(
              icon: Icons.notifications_none_rounded,
              onTap: onNotificationsTap,
            ),
            if (NotificationService
                    .instance.unreadCount >
                0)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  height: 19,
                  width: 19,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC6A06B),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    NotificationService
                        .instance.unreadCount
                        .toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GlassIconButton({
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
          color: Colors.white.withOpacity(.18),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(.28),
            width: .7,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 23,
        ),
      ),
    );
  }
}

class _NotificationFloatCard extends StatelessWidget {
  final VoidCallback onTap;

  const _NotificationFloatCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final count =
        NotificationService.instance.unreadCount;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.fromLTRB(16, 13, 14, 13),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.22),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.white.withOpacity(.26),
            width: .7,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
              size: 20,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                count == 1
                    ? 'You have 1 new notification.'
                    : 'You have $count new notifications.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.3,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _SubtleDevotionalText extends StatelessWidget {
  final String reference;
  final String verse;
  final VoidCallback onReadMore;

  const _SubtleDevotionalText({
    required this.reference,
    required this.verse,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            reference,
            style: TextStyle(
              color: Colors.white.withOpacity(.82),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.4,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            '“$verse”',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 27,
              height: 1.18,
              fontWeight: FontWeight.w300,
              letterSpacing: -.4,
            ),
          ),

          const SizedBox(height: 13),

          GestureDetector(
            onTap: onReadMore,
            child: Text(
              'Read More  →',
              style: TextStyle(
                color: Colors.white.withOpacity(.86),
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: .8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}