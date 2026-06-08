class GoalModel {
  final String id;
  final String title;
  final String subtitle;
  final double progress;
  final String category;

  const GoalModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.category,
  });

  GoalModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    double? progress,
    String? category,
  }) {
    return GoalModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      progress: progress ?? this.progress,
      category: category ?? this.category,
    );
  }
}
