class DocumentModel {
  final String id;
  final String title;
  final String category;
  final String fileType;
  final String localPath;
  final String connectedSpace;
  final DateTime uploadedAt;

  const DocumentModel({
    required this.id,
    required this.title,
    required this.category,
    required this.fileType,
    required this.localPath,
    required this.connectedSpace,
    required this.uploadedAt,
  });

  DocumentModel copyWith({
    String? id,
    String? title,
    String? category,
    String? fileType,
    String? localPath,
    String? connectedSpace,
    DateTime? uploadedAt,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      fileType: fileType ?? this.fileType,
      localPath: localPath ?? this.localPath,
      connectedSpace: connectedSpace ?? this.connectedSpace,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}