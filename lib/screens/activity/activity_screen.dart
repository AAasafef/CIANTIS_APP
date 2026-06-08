import 'package:flutter/material.dart';

import '../../models/activity_log_item.dart';
import '../../services/activity_log_service.dart';

import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../calendar/calendar_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({
    super.key,
  });

  @override
  State<ActivityScreen> createState() =>
      _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool loading = true;
  bool showBottomNav = true;

  final ScrollController scrollController =
      ScrollController();

  List<ActivityLogItem> items = [];

  @override
  void initState() {
    super.initState();
    _loadActivity();

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

  Future<void> _loadActivity() async {
    await ActivityLogService.instance.load();

    if (!mounted) return;

    setState(() {
      items = ActivityLogService.instance.items;
      loading = false;
    });
  }

  Future<void> _clearActivity() async {
    await ActivityLogService.instance.clearActive();
    await _loadActivity();
  }

  Future<void> _deleteEntry(String id) async {
    await ActivityLogService.instance.softDelete(id);
    await _loadActivity();
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
      _openScreen(
        const SpacesScreen(),
      );
      return;
    }

    if (index == 1) {
      _openScreen(
        const CalendarScreen(),
      );
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
              'Your assistant for voice commands, summaries, reminders, search, and hands-free navigation will connect here.',
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
      body: SafeArea(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF241D18),
                ),
              )
            : SingleChildScrollView(
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
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Activity',
                                style: TextStyle(
                                  fontSize: 48,
                                  height: .95,
                                  fontWeight:
                                      FontWeight.w300,
                                  letterSpacing: -1.6,
                                  color:
                                      Color(0xFF241D18),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'EVERYTHING YOU DO',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight.w300,
                                  letterSpacing: 3.2,
                                  color:
                                      Color(0xFF8B7D72),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _clearActivity,
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFFFBF8F4)
                                      .withOpacity(.92),
                              borderRadius:
                                  BorderRadius.circular(
                                16,
                              ),
                              border: Border.all(
                                color:
                                    const Color(0xFFE2D8CD),
                                width: .7,
                              ),
                            ),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xFF241D18),
                              size: 23,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    if (items.isEmpty)
                      _EmptyActivityState(
                        onCreateTest: () async {
                          await ActivityLogService.instance
                              .addActivity(
                            title: 'Activity system created',
                            description:
                                'The global activity log is now tracking app actions.',
                            spaceId: 'system',
                            spaceName: 'Ciantis',
                            actionType: 'created',
                          );

                          await _loadActivity();
                        },
                      )
                    else
                      Column(
                        children: items.map((item) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: _ActivityTile(
                              item: item,
                              onDelete: () {
                                _deleteEntry(item.id);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _EmptyActivityState extends StatelessWidget {
  final VoidCallback onCreateTest;

  const _EmptyActivityState({
    required this.onCreateTest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        34,
        24,
        34,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4)
            .withOpacity(.88),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6DB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.timeline_rounded,
              color: Color(0xFF8B6F55),
              size: 27,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No activity yet',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 22,
              fontWeight: FontWeight.w300,
              letterSpacing: -.3,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ciantis will record updates, uploads, edits, reminders, completed goals, calendar changes, and space activity here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 13,
              fontWeight: FontWeight.w300,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: onCreateTest,
            child: const Text(
              'CREATE TEST ACTIVITY',
              style: TextStyle(
                color: Color(0xFFC6A06B),
                fontSize: 10,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final ActivityLogItem item;
  final VoidCallback onDelete;

  const _ActivityTile({
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
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
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6DB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _iconForAction(item.actionType),
              color: const Color(0xFF8B6F55),
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6F6258),
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${item.spaceName} · ${_formatTime(item.createdAt)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF8B7D72),
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            visualDensity: VisualDensity.compact,
            splashRadius: 18,
            icon: const Icon(
              Icons.close_rounded,
              size: 18,
              color: Color(0xFF8B7D72),
            ),
          ),
        ],
      ),
    );
  }

  static IconData _iconForAction(String actionType) {
    switch (actionType) {
      case 'created':
        return Icons.add_circle_outline_rounded;
      case 'updated':
        return Icons.edit_note_rounded;
      case 'deleted':
        return Icons.delete_outline_rounded;
      case 'uploaded':
        return Icons.upload_file_rounded;
      case 'completed':
        return Icons.check_circle_outline_rounded;
      case 'restored':
        return Icons.restore_rounded;
      case 'login':
        return Icons.login_rounded;
      case 'panic':
        return Icons.emergency_outlined;
      default:
        return Icons.timeline_rounded;
    }
  }

  static String _formatTime(DateTime date) {
    final hour = date.hour == 0
        ? 12
        : date.hour > 12
            ? date.hour - 12
            : date.hour;

    final minute = date.minute.toString().padLeft(
          2,
          '0',
        );

    final period = date.hour < 12 ? 'AM' : 'PM';

    return '${date.month}/${date.day}/${date.year} · $hour:$minute $period';
  }
}