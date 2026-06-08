class JournalEntryModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String category;
  final String mood;
  final String fontStyle;
  final double fontSize;
  final bool isFavorite;
  final bool isPrivate;

  const JournalEntryModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    DateTime? updatedAt,
    this.category = 'General',
    this.mood = 'Happy',
    this.fontStyle = 'Handwriting',
    this.fontSize = 25,
    this.isFavorite = false,
    this.isPrivate = false,
  }) : updatedAt = updatedAt ?? createdAt;

  JournalEntryModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    String? mood,
    String? fontStyle,
    double? fontSize,
    bool? isFavorite,
    bool? isPrivate,
  }) {
    return JournalEntryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      mood: mood ?? this.mood,
      fontStyle: fontStyle ?? this.fontStyle,
      fontSize: fontSize ?? this.fontSize,
      isFavorite: isFavorite ?? this.isFavorite,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }
}