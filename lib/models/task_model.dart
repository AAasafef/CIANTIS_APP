class TaskModel {
  final String id;

  final String title;

  final bool completed;

  final DateTime createdAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.completed,
    required this.createdAt,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    bool? completed,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      completed:
          completed ?? this.completed,
      createdAt:
          createdAt ?? this.createdAt,
    );
  }
}
