import 'package:flutter/material.dart';

enum CheckInFrequency {
  daily,
  weekly,
  monthly,
  yearly,
}

enum CheckInCategory {
  beauty,
  wellness,
  health,
  spiritual,
  family,
  school,
  work,
  business,
  home,
  custom,
}

class CheckInModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final CheckInFrequency frequency;
  final CheckInCategory category;
  final bool linkedToGoal;
  final String? goalId;
  final bool appearsOnDashboard;
  final bool appearsInBeauty;
  final bool appearsInWellness;
  final bool appearsInGoals;
  final bool appearsInActivity;
  final bool reminderEnabled;
  final TimeOfDay? reminderTime;
  final DateTime createdAt;
  DateTime? completedAt;
  bool completed;
  bool active;

  CheckInModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.frequency,
    required this.category,
    required this.linkedToGoal,
    required this.goalId,
    required this.appearsOnDashboard,
    required this.appearsInBeauty,
    required this.appearsInWellness,
    required this.appearsInGoals,
    required this.appearsInActivity,
    required this.reminderEnabled,
    required this.reminderTime,
    required this.createdAt,
    this.completedAt,
    this.completed = false,
    this.active = true,
  });

  CheckInModel copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    CheckInFrequency? frequency,
    CheckInCategory? category,
    bool? linkedToGoal,
    String? goalId,
    bool? appearsOnDashboard,
    bool? appearsInBeauty,
    bool? appearsInWellness,
    bool? appearsInGoals,
    bool? appearsInActivity,
    bool? reminderEnabled,
    TimeOfDay? reminderTime,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? completed,
    bool? active,
  }) {
    return CheckInModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      frequency: frequency ?? this.frequency,
      category: category ?? this.category,
      linkedToGoal: linkedToGoal ?? this.linkedToGoal,
      goalId: goalId ?? this.goalId,
      appearsOnDashboard:
          appearsOnDashboard ?? this.appearsOnDashboard,
      appearsInBeauty:
          appearsInBeauty ?? this.appearsInBeauty,
      appearsInWellness:
          appearsInWellness ?? this.appearsInWellness,
      appearsInGoals:
          appearsInGoals ?? this.appearsInGoals,
      appearsInActivity:
          appearsInActivity ?? this.appearsInActivity,
      reminderEnabled:
          reminderEnabled ?? this.reminderEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      completed: completed ?? this.completed,
      active: active ?? this.active,
    );
  }
}
