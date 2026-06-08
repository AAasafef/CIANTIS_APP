class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String type;
  final String spaceId;
  final String spaceName;
  final DateTime createdAt;
  final DateTime? scheduledFor;
  final bool read;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.spaceId,
    required this.spaceName,
    required this.createdAt,
    this.scheduledFor,
    this.read = false,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    String? spaceId,
    String? spaceName,
    DateTime? createdAt,
    DateTime? scheduledFor,
    bool? read,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      spaceId: spaceId ?? this.spaceId,
      spaceName: spaceName ?? this.spaceName,
      createdAt: createdAt ?? this.createdAt,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'spaceId': spaceId,
      'spaceName': spaceName,
      'createdAt': createdAt.toIso8601String(),
      'scheduledFor': scheduledFor?.toIso8601String(),
      'read': read,
    };
  }

  factory NotificationItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return NotificationItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'system',
      spaceId: json['spaceId'] ?? 'system',
      spaceName: json['spaceName'] ?? 'Ciantis',
      createdAt: DateTime.tryParse(
            json['createdAt'] ?? '',
          ) ??
          DateTime.now(),
      scheduledFor: json['scheduledFor'] == null
          ? null
          : DateTime.tryParse(
              json['scheduledFor'],
            ),
      read: json['read'] ?? false,
    );
  }
}