import 'package:flutter/material.dart';

class SpaceModel {
  final String id;

  final String name;

  final String title;

  final String description;

  final String imagePath;

  final IconData icon;

  final Color color;

  final bool locked;

  final bool hidden;

  bool selected;

  SpaceModel({
    String? id,
    String? name,
    String? title,
    required this.description,
    required this.imagePath,
    required this.icon,
    required this.color,
    this.locked = false,
    this.hidden = false,
    this.selected = false,
  })  : title = title ?? name ?? '',
        name = name ?? title ?? '',
        id = id ?? title ?? name ?? '';
}