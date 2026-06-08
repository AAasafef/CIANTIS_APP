class ReminderItem {
  final String id;
  final String title;
  final String notes;
  final String spaceId;
  final String spaceName;
  final String? linkedItemId;
  final DateTime createdAt;
  final DateTime remindAt;
  final DateTime? completedAt;
  final DateTime? deletedAt;

  const ReminderItem({
    required this.id,
    required this.title,
    required this.notes,
    required this.spaceId,
    required this.spaceName,
    this.linkedItemId,
    required this.createdAt,
    required this.remindAt,
    this.completedAt,
    this.deletedAt,
  });

  bool get isCompleted => completedAt != null;
  bool get isDeleted => deletedAt != null;

  ReminderItem copyWith({
    String? title,
    String? notes,
    DateTime? remindAt,
    DateTime? completedAt,
    DateTime? deletedAt,
    bool clearCompletedAt = false,
    bool clearDeletedAt = false,
  }) {
    return ReminderItem(
      id: id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      spaceId: spaceId,
      spaceName: spaceName,
      linkedItemId: linkedItemId,
      createdAt: createdAt,
      remindAt: remindAt ?? this.remindAt,
      completedAt:
          clearCompletedAt ? null : completedAt ?? this.completedAt,
      deletedAt: clearDeletedAt ? null : deletedAt ?? this.deletedAt,
    );
  }
}