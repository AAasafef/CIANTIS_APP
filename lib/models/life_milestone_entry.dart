class LifeMilestoneEntry {
  final String id;
  final DateTime date;
  final String title;
  final String category;
  final String? note;
  final DateTime? answeredDate;

  const LifeMilestoneEntry({
    required this.id,
    required this.date,
    required this.title,
    required this.category,
    this.note,
    this.answeredDate,
  });

  int? get daysToAnswer {
    if (answeredDate == null) return null;
    return answeredDate!.difference(date).inDays;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'title': title,
      'category': category,
      'note': note,
      'answeredDate': answeredDate?.toIso8601String(),
    };
  }

  factory LifeMilestoneEntry.fromJson(Map<String, dynamic> json) {
    return LifeMilestoneEntry(
      id: json['id']?.toString() ?? '',
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
      title: json['title']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Life',
      note: json['note']?.toString(),
      answeredDate: json['answeredDate'] == null
          ? null
          : DateTime.tryParse(json['answeredDate'].toString()),
    );
  }
}