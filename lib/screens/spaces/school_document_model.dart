class SchoolDocumentModel {
  final String id;

  final String title;

  final String category;

  final String fileType;

  final DateTime uploadedAt;

  const SchoolDocumentModel({
    required this.id,
    required this.title,
    required this.category,
    required this.fileType,
    required this.uploadedAt,
  });

  SchoolDocumentModel copyWith({
    String? id,
    String? title,
    String? category,
    String? fileType,
    DateTime? uploadedAt,
  }) {
    return SchoolDocumentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      fileType: fileType ?? this.fileType,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}