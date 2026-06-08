class SchoolDocumentModel {
  final String id;
  final String title;
  final String category;
  final String fileType;
  final String localPath;
  final DateTime uploadedAt;

  const SchoolDocumentModel({
    required this.id,
    required this.title,
    required this.category,
    required this.fileType,
    required this.localPath,
    required this.uploadedAt,
  });

  SchoolDocumentModel copyWith({
    String? id,
    String? title,
    String? category,
    String? fileType,
    String? localPath,
    DateTime? uploadedAt,
  }) {
    return SchoolDocumentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      fileType: fileType ?? this.fileType,
      localPath: localPath ?? this.localPath,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}