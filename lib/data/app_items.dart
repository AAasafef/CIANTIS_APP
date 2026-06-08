import 'package:flutter/material.dart';

class AppItem {
  final String title;
  final IconData icon;
  final Widget? screen;

  const AppItem({
    required this.title,
    required this.icon,
    this.screen,
  });
}