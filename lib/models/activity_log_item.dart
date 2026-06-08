class ActivityLogItem {
  final String id;
  final String title;
  final String description;
  final String spaceId;
  final String spaceName;
  final String actionType;
  final DateTime createdAt;
  final DateTime? deletedAt;

  const ActivityLogItem({
    required this.id,
    required this.title,
    required this.description,
    required this.spaceId,
    required this.spaceName,
    required this.actionType,
    required this.createdAt,
    this.deletedAt,
  });

  bool get isDeleted {
    return deletedAt != null;
  }

  ActivityLogItem copyWith({
    String? id,
    String? title,
    String? description,
    String? spaceId,
    String? spaceName,
    String? actionType,
    DateTime? createdAt,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
  }) {
    return ActivityLogItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      spaceId: spaceId ?? this.spaceId,
      spaceName: spaceName ?? this.spaceName,
      actionType: actionType ?? this.actionType,
      createdAt: createdAt ?? this.createdAt,
      deletedAt:
          clearDeletedAt ? null : deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'spaceId': spaceId,
      'spaceName': spaceName,
      'actionType': actionType,
      'createdAt': createdAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  factory ActivityLogItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return ActivityLogItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      spaceId: json['spaceId'] ?? '',
      spaceName: json['spaceName'] ?? '',
      actionType: json['actionType'] ?? '',
      createdAt: DateTime.tryParse(
            json['createdAt'] ?? '',
          ) ??
          DateTime.now(),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.tryParse(
              json['deletedAt'],
            ),
    );
  }
}