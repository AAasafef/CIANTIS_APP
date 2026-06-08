import 'package:flutter/material.dart';

class SideMenuItem {
  final String title;
  final IconData icon;

  const SideMenuItem({
    required this.title,
    required this.icon,
  });
}

const List<SideMenuItem> sideMenuItems = [
  SideMenuItem(
    title: 'Dashboard',
    icon: Icons.dashboard_outlined,
  ),
  SideMenuItem(
    title: 'Calendar',
    icon: Icons.calendar_month_outlined,
  ),
  SideMenuItem(
    title: 'AI',
    icon: Icons.auto_awesome_outlined,
  ),
  SideMenuItem(
    title: 'Spaces',
    icon: Icons.grid_view_rounded,
  ),
  SideMenuItem(
    title: 'Settings',
    icon: Icons.settings_outlined,
  ),
];