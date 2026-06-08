class TaskItem {
  final String id;
  final String title;
  final String notes;
  final String spaceId;
  final String spaceName;
  final String? linkedItemId;
  final DateTime createdAt;
  final DateTime? dueAt;
  final DateTime? completedAt;
  final DateTime? deletedAt;

  const TaskItem({
    required this.id,
    required this.title,
    required this.notes,
    required this.spaceId,
    required this.spaceName,
    this.linkedItemId,
    required this.createdAt,
    this.dueAt,
    this.completedAt,
    this.deletedAt,
  });

  bool get isCompleted => completedAt != null;
  bool get isDeleted => deletedAt != null;

  TaskItem copyWith({
    String? title,
    String? notes,
    DateTime? dueAt,
    DateTime? completedAt,
    DateTime? deletedAt,
    bool clearCompletedAt = false,
    bool clearDeletedAt = false,
  }) {
    return TaskItem(
      id: id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      spaceId: spaceId,
      spaceName: spaceName,
      linkedItemId: linkedItemId,
      createdAt: createdAt,
      dueAt: dueAt ?? this.dueAt,
      completedAt: clearCompletedAt ? null : completedAt ?? this.completedAt,
      deletedAt: clearDeletedAt ? null : deletedAt ?? this.deletedAt,
    );
  }
}