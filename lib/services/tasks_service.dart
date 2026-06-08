import 'package:flutter/material.dart';

import '../models/task_item.dart';
import '../models/task_model.dart';

import 'activity_log_service.dart';
import 'task_search_sync.dart';

class TasksService extends ChangeNotifier {
  static final TasksService instance = TasksService._internal();

  TasksService._internal();

  final List<TaskModel> _habitTasks = [];
  final List<TaskItem> _tasks = [];

  List<TaskModel> getTasks() {
    return [..._habitTasks];
  }

  Future<void> addTask(TaskModel task) async {
    _habitTasks.insert(0, task);

    await ActivityLogService.instance.addActivity(
      title: 'Habit Created',
      description: task.title,
      spaceId: 'habits',
      spaceName: 'Habits',
      actionType: 'created',
    );

    notifyListeners();
  }

  Future<void> toggleTask(String id) async {
    final index = _habitTasks.indexWhere(
      (task) => task.id == id,
    );

    if (index == -1) return;

    final task = _habitTasks[index];

    _habitTasks[index] = task.copyWith(
      completed: !task.completed,
    );

    await ActivityLogService.instance.addActivity(
      title: task.completed ? 'Habit Reopened' : 'Habit Completed',
      description: task.title,
      spaceId: 'habits',
      spaceName: 'Habits',
      actionType: task.completed ? 'edited' : 'completed',
    );

    notifyListeners();
  }

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

  List<TaskItem> get deletedTasks {
    final copy = _tasks.where((task) {
      return task.isDeleted;
    }).toList();

    copy.sort((a, b) {
      final aDeleted =
          a.deletedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDeleted =
          b.deletedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

      return bDeleted.compareTo(aDeleted);
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
    final taskIndex = _tasks.indexWhere(
      (task) => task.id == id,
    );

    if (taskIndex != -1) {
      final task = _tasks[taskIndex];

      final deletedTask = task.copyWith(
        deletedAt: DateTime.now(),
      );

      _tasks[taskIndex] = deletedTask;

      TaskSearchSync.syncTask(deletedTask);

      await ActivityLogService.instance.addActivity(
        title: 'Task Deleted',
        description: task.title,
        spaceId: task.spaceId,
        spaceName: task.spaceName,
        actionType: 'deleted',
      );

      notifyListeners();
      return;
    }

    final habitIndex = _habitTasks.indexWhere(
      (task) => task.id == id,
    );

    if (habitIndex == -1) return;

    final habit = _habitTasks[habitIndex];

    _habitTasks.removeAt(habitIndex);

    await ActivityLogService.instance.addActivity(
      title: 'Habit Deleted',
      description: habit.title,
      spaceId: 'habits',
      spaceName: 'Habits',
      actionType: 'deleted',
    );

    notifyListeners();
  }

  Future<void> restoreTask(String id) async {
    final index = _tasks.indexWhere(
      (task) => task.id == id,
    );

    if (index == -1) return;

    final task = _tasks[index];

    final restoredTask = task.copyWith(
      clearDeletedAt: true,
    );

    _tasks[index] = restoredTask;

    TaskSearchSync.syncTask(restoredTask);

    await ActivityLogService.instance.addActivity(
      title: 'Task Restored',
      description: task.title,
      spaceId: task.spaceId,
      spaceName: task.spaceName,
      actionType: 'restored',
    );

    notifyListeners();
  }

  Future<void> permanentlyDeleteTask(String id) async {
    TaskSearchSync.removeTask(id);

    _tasks.removeWhere(
      (task) => task.id == id,
    );

    notifyListeners();
  }

  Future<void> emptyTrash() async {
    for (final task in deletedTasks) {
      TaskSearchSync.removeTask(task.id);
    }

    _tasks.removeWhere(
      (task) => task.isDeleted,
    );

    notifyListeners();
  }

  List<TaskItem> tasksForSpace(String spaceId) {
    return tasks.where((task) {
      return task.spaceId == spaceId;
    }).toList();
  }
}