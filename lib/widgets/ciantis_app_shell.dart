import 'package:flutter/material.dart';

import '../screens/calendar/calendar_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/shared/coming_soon_screen.dart';
import '../screens/spaces/spaces_screen.dart';

import 'ciantis_text_side_menu.dart';
import 'grid_menu.dart';
import 'spaces_bottom_nav_bar.dart';

class CiantisAppShell extends StatefulWidget {
  final String title;
  final String subtitle;
  final Map<String, List<String>> drawerTabs;
  final String selectedCategory;
  final String selectedSubCategory;
  final ValueChanged<String> onMainTabSelected;
  final void Function(String category, String subCategory)
      onSubTabSelected;
  final Widget child;
  final int currentBottomNavIndex;
  final bool showBottomNav;
  final bool extendBody;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const CiantisAppShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.drawerTabs,
    required this.selectedCategory,
    required this.selectedSubCategory,
    required this.onMainTabSelected,
    required this.onSubTabSelected,
    required this.child,
    this.currentBottomNavIndex = 0,
    this.showBottomNav = true,
    this.extendBody = true,
    this.backgroundColor = const Color(0xFFF6F1EA),
    this.padding = const EdgeInsets.fromLTRB(20, 20, 20, 118),
  });

  @override
  State<CiantisAppShell> createState() =>
      _CiantisAppShellState();
}

class _CiantisAppShellState
    extends State<CiantisAppShell> {
  bool bottomNavVisible = true;

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
      _openGridMenu();
      return;
    }

    if (index == 1) {
      _openScreen(
        const CalendarScreen(),
      );
      return;
    }

    if (index == 2) {
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

    if (index == 3) {
      _openScreen(
        const SpacesScreen(),
      );
      return;
    }

    if (index == 4) {
      _openScreen(
        const SettingsScreen(),
      );
    }
  }

  bool _handleScrollNotification(
    ScrollNotification notification,
  ) {
    if (!widget.showBottomNav) return false;

    if (notification is UserScrollNotification) {
      final direction = notification.direction;

      if (direction == ScrollDirection.reverse &&
          bottomNavVisible) {
        setState(() {
          bottomNavVisible = false;
        });
      }

      if (direction == ScrollDirection.forward &&
          !bottomNavVisible) {
        setState(() {
          bottomNavVisible = true;
        });
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      drawerEnableOpenDragGesture: true,
      drawer: CiantisTextSideMenu(
        title: widget.title,
        subtitle: widget.subtitle,
        drawerTabs: widget.drawerTabs,
        selectedCategory: widget.selectedCategory,
        selectedSubCategory: widget.selectedSubCategory,
        showHomeShortcut: true,
        onMainTabSelected: widget.onMainTabSelected,
        onSubTabSelected: widget.onSubTabSelected,
      ),
      extendBody: widget.extendBody,
      bottomNavigationBar: widget.showBottomNav
          ? AnimatedSlide(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              offset: bottomNavVisible
                  ? Offset.zero
                  : const Offset(0, 1.25),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 220),
                opacity: bottomNavVisible ? 1 : 0,
                child: SpacesBottomNavBar(
                  currentIndex:
                      widget.currentBottomNavIndex,
                  onTap: _handleBottomNavTap,
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: Padding(
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}