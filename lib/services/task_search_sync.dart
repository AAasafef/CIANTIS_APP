import '../models/task_item.dart';
import '../models/search_result_item.dart';

import 'global_search_service.dart';

class TaskSearchSync {
  TaskSearchSync._();

  static void syncTask(
    TaskItem task,
  ) {
    if (task.isDeleted) {
      removeTask(task.id);
      return;
    }

    GlobalSearchService.instance.register(
      SearchResultItem(
        id: 'task_${task.id}',
        title: task.title,
        subtitle: task.spaceName,
        content:
            '${task.title} ${task.notes}',
        sourceType: 'task',
        spaceId: task.spaceId,
        spaceName: task.spaceName,
        createdAt:
            task.dueAt ??
            task.createdAt,
      ),
    );
  }

  static void removeTask(
    String id,
  ) {
    GlobalSearchService.instance.remove(
      'task_$id',
    );
  }
}