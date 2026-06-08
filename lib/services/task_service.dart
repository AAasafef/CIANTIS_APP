import 'package:flutter/material.dart';

import '../models/task_item.dart';

import 'activity_log_service.dart';
import 'task_search_sync.dart';

class TasksService extends ChangeNotifier {
  static final TasksService instance =
      TasksService._internal();

  TasksService._internal();

  final List<TaskItem> _tasks = [];

  List<TaskItem> get tasks {
    final copy = _tasks.where((task) {
      return !task.isDeleted;
    }).toList();

    copy.sort((a, b) {
      final aDate = a.dueAt ?? a.createdAt;
      final bDate = b.dueAt ?? b.createdAt;

      return aDate.compareTo(bDate);
    });

    return copy;
  }

  Future<void> createTask({
    required String title,
    String notes = '',
    required String spaceId,
    required String spaceName,
    String? linkedItemId,
    DateTime? dueAt,
  }) async {
    final now = DateTime.now();

    final task = TaskItem(
      id: now.microsecondsSinceEpoch.toString(),
      title: title,
      notes: notes,
      spaceId: spaceId,
      spaceName: spaceName,
      linkedItemId: linkedItemId,
      createdAt: now,
      dueAt: dueAt,
    );

    _tasks.insert(0, task);

    TaskSearchSync.syncTask(task);

    await ActivityLogService.instance.addActivity(
      title: 'Task Created',
      description: title,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: 'created',
    );

    notifyListeners();
  }

  Future<void> completeTask(String id) async {
    final index = _tasks.indexWhere(
      (task) => task.id == id,
    );

    if (index == -1) return;

    final task = _tasks[index];

    final updatedTask = task.copyWith(
      completedAt: DateTime.now(),
    );

    _tasks[index] = updatedTask;

    TaskSearchSync.syncTask(updatedTask);

    await ActivityLogService.instance.addActivity(
      title: 'Task Completed',
      description: task.title,
      spaceId: task.spaceId,
      spaceName: task.spaceName,
      actionType: 'completed',
    );

    notifyListeners();
  }

  Future<void> reopenTask(String id) async {
    final index = _tasks.indexWhere(
      (task) => task.id == id,
    );

    if (index == -1) return;

    final task = _tasks[index];

    final updatedTask = task.copyWith(
      clearCompletedAt: true,
    );

    _tasks[index] = updatedTask;

    TaskSearchSync.syncTask(updatedTask);

    await ActivityLogService.instance.addActivity(
      title: 'Task Reopened',
      description: task.title,
      spaceId: task.spaceId,
      spaceName: task.spaceName,
      actionType: 'edited',
    );

    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    final index = _tasks.indexWhere(
      (task) => task.id == id,
    );

    if (index == -1) return;

    final task = _tasks[index];

    final deletedTask = task.copyWith(
      deletedAt: DateTime.now(),
    );

    _tasks[index] = deletedTask;

    TaskSearchSync.syncTask(deletedTask);

    await ActivityLogService.instance.addActivity(
      title: 'Task Deleted',
      description: task.title,
      spaceId: task.spaceId,
      spaceName: task.spaceName,
      actionType: 'deleted',
    );

    notifyListeners();
  }

  List<TaskItem> tasksForSpace(String spaceId) {
    return tasks.where((task) {
      return task.spaceId == spaceId;
    }).toList();
  }
}