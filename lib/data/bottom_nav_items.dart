import 'package:flutter/material.dart';

class BottomNavItem {
  final String title;
  final IconData icon;

  const BottomNavItem({
    required this.title,
    required this.icon,
  });
}

const List<BottomNavItem> bottomNavItems = [
  BottomNavItem(
    title: 'Menu',
    icon: Icons.grid_view_rounded,
  ),

  BottomNavItem(
    title: 'Calendar',
    icon: Icons.calendar_month_outlined,
  ),

  BottomNavItem(
    title: 'AI',
    icon: Icons.auto_awesome_outlined,
  ),

  BottomNavItem(
    title: 'Spaces',
    icon: Icons.dashboard_customize_outlined,
  ),

  BottomNavItem(
    title: 'Settings',
    icon: Icons.tune_rounded,
  ),
];