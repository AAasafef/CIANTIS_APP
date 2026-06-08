import 'package:flutter/material.dart';

import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/grid_menu.dart';
import '../../widgets/spaces_bottom_nav_bar.dart';

import '../../services/notification_service.dart';

import '../activity/activity_screen.dart';
import '../notifications/notifications_screen.dart';
import '../calendar/calendar_screen.dart';
import '../search/global_search_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/coming_soon_screen.dart';
import '../spaces/spaces_screen.dart';

import 'daily_check_in_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController scrollController = ScrollController();
  bool showBottomNav = true;

  final List<_DashboardCheckInTask> _checkIns = [
    _DashboardCheckInTask(
      title: 'Drink Water',
      subtitle: '6 of 8 bottles today',
      icon: Icons.water_drop_outlined,
      frequency: 'Daily',
      category: 'Wellness + Beauty',
      progress: .75,
      goalKey: 'hydration_daily',
      completed: false,
      status: _CheckInStatus.partial,
    ),
    _DashboardCheckInTask(
      title: 'Skincare Routine',
      subtitle: 'Morning or night care',
      icon: Icons.spa_outlined,
      frequency: 'Daily',
      category: 'Beauty',
      progress: 1,
      goalKey: 'beauty_skincare_daily',
      completed: true,
      status: _CheckInStatus.complete,
    ),
    _DashboardCheckInTask(
      title: 'Clean Inside Ears',
      subtitle: 'Gentle q-tip reminder',
      icon: Icons.hearing_outlined,
      frequency: 'Weekly',
      category: 'Beauty Hygiene',
      progress: 0,
      goalKey: 'beauty_ears_weekly',
      completed: false,
      status: _CheckInStatus.due,
    ),
    _DashboardCheckInTask(
      title: 'Body Moisture',
      subtitle: 'Lotion, oil, or body butter',
      icon: Icons.auto_awesome_outlined,
      frequency: 'Daily',
      category: 'Beauty',
      progress: 0,
      goalKey: 'beauty_body_moisture',
      completed: false,
      status: _CheckInStatus.due,
    ),
    _DashboardCheckInTask(
      title: 'Hair Protected',
      subtitle: 'Wrap, bonnet, scarf, or style reset',
      icon: Icons.face_retouching_natural_outlined,
      frequency: 'Daily',
      category: 'Hair',
      progress: 1,
      goalKey: 'beauty_hair_protection',
      completed: true,
      status: _CheckInStatus.complete,
    ),
    _DashboardCheckInTask(
      title: 'Shave / Groom',
      subtitle: 'Twice monthly by default',
      icon: Icons.content_cut_rounded,
      frequency: 'Monthly',
      category: 'Beauty Grooming',
      progress: 0,
      goalKey: 'beauty_shave_monthly',
      completed: false,
      status: _CheckInStatus.notDue,
    ),
  ];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final direction = scrollController.position.userScrollDirection;
      if (direction.toString().contains('reverse') && showBottomNav) {
        setState(() => showBottomNav = false);
      }
      if (direction.toString().contains('forward') && !showBottomNav) {
        setState(() => showBottomNav = true);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  int get _completedCount => _checkIns.where((task) => task.completed).length;
  int get _dueCount => _checkIns.where((task) => task.status != _CheckInStatus.notDue).length;

  void _openGridMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const GridMenu(),
    );
  }

  void _openScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void _openFullCheckInDashboard() {
    _openScreen(const DailyCheckInScreen());
  }

  void _toggleTask(_DashboardCheckInTask task) {
    setState(() {
      task.completed = !task.completed;
      task.progress = task.completed ? 1 : task.progress;
      task.status = task.completed ? _CheckInStatus.complete : _CheckInStatus.due;
    });
  }

  void _showCheckInSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _CheckInBottomSheet(
        tasks: _checkIns,
        onTaskTap: _showTaskDetails,
        onToggleTask: _toggleTask,
        onViewAll: _openFullCheckInDashboard,
      ),
    );
  }

  void _showTaskDetails(_DashboardCheckInTask task) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _CheckInTaskDetailsSheet(
        task: task,
        onCompleted: () {
          Navigator.pop(context);
          _toggleTask(task);
        },
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    if (index == 0) return _openScreen(const SpacesScreen());
    if (index == 1) return _openScreen(const CalendarScreen());
    if (index == 2) return _openGridMenu();
    if (index == 3) {
      return _openScreen(const ComingSoonScreen(
        title: 'AI',
        subtitle: 'Your assistant for voice commands, reminders, summaries, and hands-free navigation will connect here.',
        icon: Icons.auto_awesome_rounded,
      ));
    }
    if (index == 4) return _openScreen(const SettingsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _CiantisColors.cream,
      drawer: const CiantisSideDrawer(),
      extendBody: true,
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        offset: showBottomNav ? Offset.zero : const Offset(0, 1.25),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: showBottomNav ? 1 : 0,
          child: SpacesBottomNavBar(currentIndex: 2, onTap: _handleBottomNavTap),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 128),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ciantis',
                          style: TextStyle(
                            fontSize: 48,
                            height: .95,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -1.6,
                            color: _CiantisColors.ink,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'LIFE OS DASHBOARD',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3.2,
                            color: _CiantisColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _TopIconButton(
                        icon: Icons.search_rounded,
                        onTap: () => _openScreen(const GlobalSearchScreen()),
                      ),
                      const SizedBox(width: 10),
                      _CheckInTopButton(
                        completed: _completedCount,
                        total: _dueCount,
                        onTap: _showCheckInSheet,
                      ),
                      const SizedBox(width: 10),
                      _TopIconButton(
                        icon: Icons.timeline_rounded,
                        onTap: () => _openScreen(const ActivityScreen()),
                      ),
                      const SizedBox(width: 10),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _TopIconButton(
                            icon: Icons.notifications_none_rounded,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                              );
                              if (mounted) setState(() {});
                            },
                          ),
                          if (NotificationService.instance.unreadCount > 0)
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                height: 20,
                                width: 20,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: _CiantisColors.gold,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  NotificationService.instance.unreadCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _HeroFocusCard(onTap: _openFullCheckInDashboard),
              const SizedBox(height: 22),
              const Text(
                'Today',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -.4,
                  color: _CiantisColors.ink,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: const [
                  Expanded(child: _MetricCard(label: 'Tasks', value: '3', subtitle: 'Remaining', icon: Icons.check_circle_outline)),
                  SizedBox(width: 12),
                  Expanded(child: _MetricCard(label: 'Events', value: '2', subtitle: 'Today', icon: Icons.calendar_month_outlined)),
                  SizedBox(width: 12),
                  Expanded(child: _MetricCard(label: 'Spaces', value: '8', subtitle: 'Active', icon: Icons.grid_view_rounded)),
                ],
              ),
              const SizedBox(height: 22),
              _DashboardCheckInsCard(
                completed: _completedCount,
                total: _dueCount,
                tasks: _checkIns,
                onTap: _showCheckInSheet,
                onTaskTap: _showTaskDetails,
                onToggleTask: _toggleTask,
              ),
              const SizedBox(height: 22),
              _InsightCard(
                title: 'AI Daily Brief',
                subtitle: 'Your reminders, schedule, priorities, and wellness notes will appear here.',
                icon: Icons.auto_awesome_rounded,
                imagePath: 'assets/images/spaces/spiritual.jpg',
                onTap: () => _openScreen(const ComingSoonScreen(
                  title: 'AI Daily Brief',
                  subtitle: 'Your assistant will summarize your day, reminders, spaces, documents, and priorities here.',
                  icon: Icons.auto_awesome_rounded,
                )),
              ),
              const SizedBox(height: 14),
              _SimpleCard(
                title: 'Today’s Priorities',
                subtitle: 'Your top tasks, appointments, reminders, and unfinished items will appear here.',
                icon: Icons.flag_outlined,
                onTap: () => _openScreen(const ComingSoonScreen(
                  title: 'Today’s Priorities',
                  subtitle: 'Your most important priorities for the day will live here.',
                  icon: Icons.flag_outlined,
                )),
              ),
              const SizedBox(height: 14),
              _SimpleCard(
                title: 'Spaces Needing Attention',
                subtitle: 'Ciantis will show spaces with updates, overdue items, or reminders here.',
                icon: Icons.dashboard_customize_outlined,
                onTap: () => _openScreen(const SpacesScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _CheckInStatus { due, partial, complete, notDue }

class _DashboardCheckInTask {
  final String title;
  final String subtitle;
  final IconData icon;
  final String frequency;
  final String category;
  final String goalKey;
  double progress;
  bool completed;
  _CheckInStatus status;

  _DashboardCheckInTask({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.frequency,
    required this.category,
    required this.progress,
    required this.goalKey,
    required this.completed,
    required this.status,
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

class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _TopIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: _CiantisColors.card.withOpacity(.92),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _CiantisColors.softBorder, width: .7),
        ),
        child: Icon(icon, color: _CiantisColors.ink, size: 22),
      ),
    );
  }
}

class _CheckInTopButton extends StatelessWidget {
  final int completed;
  final int total;
  final VoidCallback onTap;
  const _CheckInTopButton({required this.completed, required this.total, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool done = total > 0 && completed >= total;
    final Color glowColor = done ? _CiantisColors.complete : _CiantisColors.gold;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: _CiantisColors.card.withOpacity(.95),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: glowColor.withOpacity(.72), width: 1),
          boxShadow: [BoxShadow(color: glowColor.withOpacity(.26), blurRadius: 18, offset: const Offset(0, 8))],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(done ? Icons.check_rounded : Icons.fact_check_outlined, color: done ? _CiantisColors.complete : _CiantisColors.ink, size: 22),
            if (!done)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(color: _CiantisColors.gold, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _HeroFocusCard extends StatelessWidget {
  final VoidCallback onTap;
  const _HeroFocusCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 230,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(.10), blurRadius: 26, offset: const Offset(0, 16))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset('assets/images/spaces/spiritual.jpg', fit: BoxFit.cover)),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(.10), Colors.black.withOpacity(.28), Colors.black.withOpacity(.72)],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TODAY’S DEVOTIONAL', style: TextStyle(color: Color(0xFFE8D6B8), fontSize: 10, fontWeight: FontWeight.w300, letterSpacing: 2.4)),
                    const SizedBox(height: 10),
                    const Text('“Be still, and know that I am God.”', style: TextStyle(color: Color(0xFFFFF9F1), fontSize: 23, fontWeight: FontWeight.w300, letterSpacing: -.3, height: 1.15)),
                    const SizedBox(height: 7),
                    Text('Psalm 46:10', style: TextStyle(color: Colors.white.withOpacity(.74), fontSize: 12, fontWeight: FontWeight.w300, letterSpacing: 1.4)),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _HeroTextAction(label: 'Read More', onTap: onTap),
                        const SizedBox(width: 18),
                        _HeroTextAction(label: 'Prayer', onTap: onTap),
                        const SizedBox(width: 18),
                        _HeroTextAction(label: 'Reflect', onTap: onTap),
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

class _HeroTextAction extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _HeroTextAction({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(label, style: const TextStyle(color: _CiantisColors.gold, fontSize: 11, fontWeight: FontWeight.w300, letterSpacing: 1.6)),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final IconData icon;
  const _MetricCard({required this.label, required this.value, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _CiantisColors.card.withOpacity(.88),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _CiantisColors.softBorder, width: .7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _CiantisColors.taupe, size: 21),
          const Spacer(),
          Text(value, style: const TextStyle(color: _CiantisColors.ink, fontSize: 28, fontWeight: FontWeight.w300, height: 1)),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: _CiantisColors.ink, fontSize: 12, fontWeight: FontWeight.w400)),
          Text(subtitle, style: const TextStyle(color: _CiantisColors.muted, fontSize: 10, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}

class _DashboardCheckInsCard extends StatelessWidget {
  final int completed;
  final int total;
  final List<_DashboardCheckInTask> tasks;
  final VoidCallback onTap;
  final ValueChanged<_DashboardCheckInTask> onTaskTap;
  final ValueChanged<_DashboardCheckInTask> onToggleTask;
  const _DashboardCheckInsCard({required this.completed, required this.total, required this.tasks, required this.onTap, required this.onTaskTap, required this.onToggleTask});

  @override
  Widget build(BuildContext context) {
    final double percent = total == 0 ? 0 : completed / total;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _CiantisColors.card.withOpacity(.90),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: _CiantisColors.softBorder, width: .7),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(.045), blurRadius: 22, offset: const Offset(0, 12))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(child: Text('Today’s Check-Ins', style: TextStyle(color: _CiantisColors.ink, fontSize: 20, fontWeight: FontWeight.w300, letterSpacing: -.25))),
                Text('View all', style: TextStyle(color: _CiantisColors.taupe.withOpacity(.95), fontSize: 12, fontWeight: FontWeight.w300, letterSpacing: .4)),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right_rounded, color: _CiantisColors.muted, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            Row(
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
                          backgroundColor: _CiantisColors.softTaupe,
                          valueColor: AlwaysStoppedAnimation<Color>(completed >= total && total > 0 ? _CiantisColors.complete : _CiantisColors.gold),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('$completed/$total', style: const TextStyle(color: _CiantisColors.ink, fontSize: 20, fontWeight: FontWeight.w300, height: 1)),
                          const SizedBox(height: 4),
                          const Text('Done', style: TextStyle(color: _CiantisColors.muted, fontSize: 10, fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    children: tasks.where((task) => task.status != _CheckInStatus.notDue).take(3).map((task) {
                      return _SmallCheckInRow(task: task, onTap: () => onTaskTap(task), onToggle: () => onToggleTask(task));
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: _CiantisColors.softBorder),
            const SizedBox(height: 14),
            const Text('Linked goals update everywhere: Beauty, Wellness, Dashboard, and Goals all read from the same task data.', style: TextStyle(color: _CiantisColors.muted, fontSize: 11, fontWeight: FontWeight.w300, height: 1.35)),
          ],
        ),
      ),
    );
  }
}

class _SmallCheckInRow extends StatelessWidget {
  final _DashboardCheckInTask task;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  const _SmallCheckInRow({required this.task, required this.onTap, required this.onToggle});

  Color get glow {
    switch (task.status) {
      case _CheckInStatus.complete: return _CiantisColors.complete;
      case _CheckInStatus.partial: return _CiantisColors.gold;
      case _CheckInStatus.due: return _CiantisColors.taupe;
      case _CheckInStatus.notDue: return _CiantisColors.softBorder;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 9),
        child: Row(
          children: [
            GestureDetector(
              onTap: onToggle,
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: task.completed ? glow.withOpacity(.12) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: glow.withOpacity(.75), width: .9),
                ),
                child: Icon(task.completed ? Icons.check_rounded : task.icon, size: 15, color: glow),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(child: Text(task.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _CiantisColors.ink, fontSize: 12, fontWeight: FontWeight.w300))),
            Text(task.completed ? 'Done' : task.status == _CheckInStatus.partial ? 'Partial' : 'Due', style: TextStyle(color: glow, fontSize: 10, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}

class _CheckInBottomSheet extends StatelessWidget {
  final List<_DashboardCheckInTask> tasks;
  final ValueChanged<_DashboardCheckInTask> onTaskTap;
  final ValueChanged<_DashboardCheckInTask> onToggleTask;
  final VoidCallback onViewAll;
  const _CheckInBottomSheet({required this.tasks, required this.onTaskTap, required this.onToggleTask, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final visibleTasks = tasks.where((task) => task.status != _CheckInStatus.notDue).toList();
    return DraggableScrollableSheet(
      initialChildSize: .74,
      minChildSize: .48,
      maxChildSize: .92,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(color: _CiantisColors.cream, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 34),
            children: [
              Center(child: Container(height: 4, width: 46, decoration: BoxDecoration(color: _CiantisColors.softBorder, borderRadius: BorderRadius.circular(99)))),
              const SizedBox(height: 22),
              Row(
                children: [
                  const Expanded(child: Text('Check-Ins', style: TextStyle(color: _CiantisColors.ink, fontSize: 28, fontWeight: FontWeight.w300, letterSpacing: -.5))),
                  _SheetCloseButton(onTap: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: 6),
              const Text('Quick, soft, and not overwhelming. Complete what is due today only.', style: TextStyle(color: _CiantisColors.muted, fontSize: 12, fontWeight: FontWeight.w300, height: 1.35)),
              const SizedBox(height: 18),
              _CheckInFrequencyGrid(onViewAll: onViewAll),
              const SizedBox(height: 18),
              _SectionTitle(title: 'Due Today', trailing: '${visibleTasks.length} showing'),
              const SizedBox(height: 10),
              ...visibleTasks.map((task) => _CheckInListTile(task: task, onTap: () => onTaskTap(task), onToggle: () => onToggleTask(task))),
              const SizedBox(height: 14),
              _AddCustomCheckInButton(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ComingSoonScreen(
                        title: 'Custom Check-In',
                        subtitle: 'Create your own check-in task, choose frequency, connect it to a goal, and decide which spaces should show it.',
                        icon: Icons.add_task_rounded,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 14),
              const _SyncNoticeCard(),
            ],
          ),
        );
      },
    );
  }
}

class _CheckInFrequencyGrid extends StatelessWidget {
  final VoidCallback onViewAll;
  const _CheckInFrequencyGrid({required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Daily', 'Every day', Icons.wb_sunny_outlined),
      ('Weekly', 'Selected day', Icons.calendar_view_week_outlined),
      ('Monthly', '1st or last day', Icons.calendar_month_outlined),
      ('Yearly', 'Dec 31 / Jan 1', Icons.workspace_premium_outlined),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 92, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemBuilder: (_, index) {
        final item = items[index];
        return GestureDetector(
          onTap: onViewAll,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: _CiantisColors.card.withOpacity(.82), borderRadius: BorderRadius.circular(22), border: Border.all(color: _CiantisColors.softBorder, width: .75)),
            child: Row(
              children: [
                Container(height: 42, width: 42, decoration: BoxDecoration(color: _CiantisColors.softTaupe, borderRadius: BorderRadius.circular(16)), child: Icon(item.$3, color: _CiantisColors.taupe, size: 22)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.$1, style: const TextStyle(color: _CiantisColors.ink, fontSize: 15, fontWeight: FontWeight.w300)),
                      const SizedBox(height: 4),
                      Text(item.$2, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _CiantisColors.muted, fontSize: 10, fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CheckInListTile extends StatelessWidget {
  final _DashboardCheckInTask task;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  const _CheckInListTile({required this.task, required this.onTap, required this.onToggle});

  Color get statusColor {
    switch (task.status) {
      case _CheckInStatus.complete: return _CiantisColors.complete;
      case _CheckInStatus.partial: return _CiantisColors.gold;
      case _CheckInStatus.due: return _CiantisColors.taupe;
      case _CheckInStatus.notDue: return _CiantisColors.softBorder;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _CiantisColors.card.withOpacity(.82),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: statusColor.withOpacity(.34), width: .85),
        boxShadow: [if (task.status == _CheckInStatus.complete) BoxShadow(color: statusColor.withOpacity(.12), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: ListTile(
        onTap: onTap,
        minLeadingWidth: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(color: _CiantisColors.softTaupe.withOpacity(.85), borderRadius: BorderRadius.circular(15)),
          child: Icon(task.icon, color: _CiantisColors.taupe, size: 21),
        ),
        title: Text(task.title, style: const TextStyle(color: _CiantisColors.ink, fontSize: 14, fontWeight: FontWeight.w300)),
        subtitle: Text('${task.subtitle}  •  ${task.frequency}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _CiantisColors.muted, fontSize: 10, fontWeight: FontWeight.w300)),
        trailing: GestureDetector(
          onTap: onToggle,
          child: Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(shape: BoxShape.circle, color: task.completed ? statusColor.withOpacity(.12) : Colors.transparent, border: Border.all(color: statusColor.withOpacity(.72), width: .9)),
            child: Icon(task.completed ? Icons.check_rounded : Icons.circle_outlined, color: statusColor, size: task.completed ? 19 : 15),
          ),
        ),
      ),
    );
  }
}

class _CheckInTaskDetailsSheet extends StatelessWidget {
  final _DashboardCheckInTask task;
  final VoidCallback onCompleted;
  const _CheckInTaskDetailsSheet({required this.task, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final bool isComplete = task.completed;
    return Container(
      decoration: const BoxDecoration(color: _CiantisColors.cream, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 34),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(height: 4, width: 46, decoration: BoxDecoration(color: _CiantisColors.softBorder, borderRadius: BorderRadius.circular(99)))),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(child: Text(task.title, style: const TextStyle(color: _CiantisColors.ink, fontSize: 26, fontWeight: FontWeight.w300, letterSpacing: -.4))),
                _SheetCloseButton(onTap: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 18),
            Center(
              child: Container(
                height: 108,
                width: 108,
                decoration: BoxDecoration(
                  color: _CiantisColors.card,
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(color: isComplete ? _CiantisColors.complete.withOpacity(.55) : _CiantisColors.softBorder, width: 1),
                  boxShadow: [BoxShadow(color: (isComplete ? _CiantisColors.complete : _CiantisColors.gold).withOpacity(.14), blurRadius: 24, offset: const Offset(0, 12))],
                ),
                child: Icon(isComplete ? Icons.check_rounded : task.icon, color: isComplete ? _CiantisColors.complete : _CiantisColors.taupe, size: 48),
              ),
            ),
            const SizedBox(height: 22),
            Text(task.subtitle, style: const TextStyle(color: _CiantisColors.ink, fontSize: 16, fontWeight: FontWeight.w300, height: 1.35)),
            const SizedBox(height: 16),
            const Text('Why this matters', style: TextStyle(color: _CiantisColors.ink, fontSize: 13, fontWeight: FontWeight.w400)),
            const SizedBox(height: 8),
            const Text('Small maintenance habits protect your confidence, comfort, hygiene, and beauty routine without making the app feel heavy.', style: TextStyle(color: _CiantisColors.muted, fontSize: 12, fontWeight: FontWeight.w300, height: 1.45)),
            const SizedBox(height: 16),
            _DetailInfoRow(label: 'Frequency', value: task.frequency),
            _DetailInfoRow(label: 'Category', value: task.category),
            _DetailInfoRow(label: 'Goal Sync Key', value: task.goalKey),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: isComplete ? null : onCompleted,
              child: Container(
                height: 52,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isComplete ? _CiantisColors.complete.withOpacity(.12) : _CiantisColors.deepBrown,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: isComplete ? _CiantisColors.complete.withOpacity(.55) : _CiantisColors.deepBrown, width: .8),
                ),
                child: Text(isComplete ? 'Completed Today' : 'Mark as Complete', style: TextStyle(color: isComplete ? _CiantisColors.complete : _CiantisColors.card, fontSize: 13, fontWeight: FontWeight.w300, letterSpacing: .4)),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 48,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: _CiantisColors.card.withOpacity(.85), borderRadius: BorderRadius.circular(18), border: Border.all(color: _CiantisColors.softBorder, width: .8)),
                child: const Text('Snooze / Remind Me Later', style: TextStyle(color: _CiantisColors.taupe, fontSize: 12, fontWeight: FontWeight.w300, letterSpacing: .4)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: _CiantisColors.muted, fontSize: 12, fontWeight: FontWeight.w300))),
          Text(value, style: const TextStyle(color: _CiantisColors.ink, fontSize: 12, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}

class _AddCustomCheckInButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddCustomCheckInButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: _CiantisColors.deepBrown, borderRadius: BorderRadius.circular(18)),
        child: const Text('+ Add Custom Check-In', style: TextStyle(color: _CiantisColors.card, fontSize: 13, fontWeight: FontWeight.w300, letterSpacing: .4)),
      ),
    );
  }
}

class _SyncNoticeCard extends StatelessWidget {
  const _SyncNoticeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: _CiantisColors.softTaupe.withOpacity(.62), borderRadius: BorderRadius.circular(18), border: Border.all(color: _CiantisColors.softBorder, width: .75)),
      child: const Row(
        children: [
          Icon(Icons.link_rounded, color: _CiantisColors.taupe, size: 20),
          SizedBox(width: 10),
          Expanded(child: Text('One goal. One progress record. Updates in Beauty, Wellness, Goals, and Dashboard stay connected.', style: TextStyle(color: _CiantisColors.muted, fontSize: 11, fontWeight: FontWeight.w300, height: 1.35))),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String trailing;
  const _SectionTitle({required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(color: _CiantisColors.ink, fontSize: 16, fontWeight: FontWeight.w300))),
        Text(trailing, style: const TextStyle(color: _CiantisColors.muted, fontSize: 11, fontWeight: FontWeight.w300)),
      ],
    );
  }
}

class _SheetCloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SheetCloseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(color: _CiantisColors.card.withOpacity(.88), borderRadius: BorderRadius.circular(14), border: Border.all(color: _CiantisColors.softBorder, width: .7)),
        child: const Icon(Icons.close_rounded, color: _CiantisColors.ink, size: 19),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String imagePath;
  final VoidCallback onTap;
  const _InsightCard({required this.title, required this.subtitle, required this.icon, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(color: _CiantisColors.card.withOpacity(.90), borderRadius: BorderRadius.circular(24), border: Border.all(color: _CiantisColors.softBorder, width: .7)),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: _CiantisColors.taupe, size: 22),
                    const Spacer(),
                    Text(title, style: const TextStyle(color: _CiantisColors.ink, fontSize: 18, fontWeight: FontWeight.w300, letterSpacing: -.2)),
                    const SizedBox(height: 6),
                    Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF6F6258), fontSize: 12, fontWeight: FontWeight.w300, height: 1.35)),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(24), bottomRight: Radius.circular(24)),
              child: SizedBox(width: 118, height: double.infinity, child: Image.asset(imagePath, fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimpleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const _SimpleCard({required this.title, required this.subtitle, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: _CiantisColors.card.withOpacity(.88), borderRadius: BorderRadius.circular(22), border: Border.all(color: _CiantisColors.softBorder, width: .7)),
        child: Row(
          children: [
            Container(height: 44, width: 44, decoration: BoxDecoration(color: _CiantisColors.softTaupe, borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: _CiantisColors.taupe, size: 22)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: _CiantisColors.ink, fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: -.1)),
                  const SizedBox(height: 5),
                  Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF6F6258), fontSize: 12, fontWeight: FontWeight.w300, height: 1.35)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF9A8D83), size: 22),
          ],
        ),
      ),
    );
  }
}
