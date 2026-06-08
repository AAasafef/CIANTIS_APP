class TagItem {
  final String id;
  final String name;
  final DateTime createdAt;

  const TagItem({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TagItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return TagItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      createdAt: DateTime.tryParse(
            json['createdAt'] ?? '',
          ) ??
          DateTime.now(),
    );
  }
}