import 'package:flutter/material.dart';

import '../../models/notification_item.dart';
import '../../services/notification_service.dart';

import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../calendar/calendar_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  bool loading = true;
  bool showBottomNav = true;

  final ScrollController scrollController =
      ScrollController();

  List<NotificationItem> items = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();

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

  Future<void> _loadNotifications() async {
    await NotificationService.instance.load();

    if (!mounted) return;

    setState(() {
      items = NotificationService.instance.items;
      loading = false;
    });
  }

  Future<void> _markAllRead() async {
    await NotificationService.instance.markAllRead();
    await _loadNotifications();
  }

  Future<void> _clearAll() async {
    await NotificationService.instance.clearAll();
    await _loadNotifications();
  }

  Future<void> _createTestNotification() async {
    await NotificationService.instance.addNotification(
      title: 'Notification system created',
      message:
          'Ciantis can now store reminders, alerts, deadlines, and app notifications.',
      type: 'system',
      spaceId: 'system',
      spaceName: 'Ciantis',
    );

    await _loadNotifications();
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
    final unreadCount = items.where((item) {
      return !item.read;
    }).length;

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
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 42,
                                  height: .98,
                                  fontWeight:
                                      FontWeight.w300,
                                  letterSpacing: -1.4,
                                  color:
                                      Color(0xFF241D18),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                unreadCount == 0
                                    ? 'ALL CAUGHT UP'
                                    : '$unreadCount UNREAD',
                                style: const TextStyle(
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
                        _TopActionButton(
                          icon: Icons.done_all_rounded,
                          onTap: _markAllRead,
                        ),
                        const SizedBox(width: 10),
                        _TopActionButton(
                          icon: Icons.delete_outline_rounded,
                          onTap: _clearAll,
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    if (items.isEmpty)
                      _EmptyNotificationsState(
                        onCreateTest: _createTestNotification,
                      )
                    else
                      Column(
                        children: items.map((item) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: _NotificationTile(
                              item: item,
                              onTap: () async {
                                await NotificationService
                                    .instance
                                    .markRead(item.id);

                                await _loadNotifications();
                              },
                              onDelete: () async {
                                await NotificationService
                                    .instance
                                    .deleteNotification(
                                  item.id,
                                );

                                await _loadNotifications();
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

class _TopActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopActionButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4)
              .withOpacity(.92),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2D8CD),
            width: .7,
          ),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF241D18),
          size: 22,
        ),
      ),
    );
  }
}

class _EmptyNotificationsState extends StatelessWidget {
  final VoidCallback onCreateTest;

  const _EmptyNotificationsState({
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
              Icons.notifications_none_rounded,
              color: Color(0xFF8B6F55),
              size: 27,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No notifications',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 22,
              fontWeight: FontWeight.w300,
              letterSpacing: -.3,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Reminders, bills, appointments, health alerts, client updates, deadlines, and space notifications will appear here.',
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
              'CREATE TEST NOTIFICATION',
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

class _NotificationTile extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _NotificationTile({
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final unread = !item.read;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4)
              .withOpacity(.88),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: unread
                ? const Color(0xFFC6A06B)
                : const Color(0xFFE2D8CD),
            width: unread ? 1 : .7,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: unread
                    ? const Color(0xFF241D18)
                    : const Color(0xFFF0E6DB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _iconForType(item.type),
                color: unread
                    ? const Color(0xFFFFF9F1)
                    : const Color(0xFF8B6F55),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Color(0xFF241D18),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -.1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF6F6258),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${item.spaceName} · ${_formatTime(item.createdAt)}',
                    style: const TextStyle(
                      color: Color(0xFF8B7D72),
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onDelete,
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFF9A8D83),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static IconData _iconForType(String type) {
    switch (type) {
      case 'calendar':
        return Icons.calendar_month_outlined;
      case 'reminder':
        return Icons.notifications_none_rounded;
      case 'bill':
        return Icons.receipt_long_outlined;
      case 'health':
        return Icons.favorite_border;
      case 'client':
        return Icons.person_outline_rounded;
      case 'document':
        return Icons.folder_copy_outlined;
      case 'goal':
        return Icons.flag_outlined;
      default:
        return Icons.notifications_none_rounded;
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