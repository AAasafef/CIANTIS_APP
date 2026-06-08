class NoteItem {
  final String id;
  final String title;
  final String body;
  final String spaceId;
  final String spaceName;
  final String? linkedItemId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const NoteItem({
    required this.id,
    required this.title,
    required this.body,
    required this.spaceId,
    required this.spaceName,
    this.linkedItemId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  bool get isDeleted {
    return deletedAt != null;
  }

  NoteItem copyWith({
    String? id,
    String? title,
    String? body,
    String? spaceId,
    String? spaceName,
    String? linkedItemId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
  }) {
    return NoteItem(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      spaceId: spaceId ?? this.spaceId,
      spaceName: spaceName ?? this.spaceName,
      linkedItemId: linkedItemId ?? this.linkedItemId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: clearDeletedAt ? null : deletedAt ?? this.deletedAt,
    );
  }
}