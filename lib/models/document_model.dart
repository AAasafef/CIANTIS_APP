class DocumentModel {
  final String id;

  final String title;

  final String category;

  final String fileType;

  final String localPath;

  final String connectedSpace;

  final DateTime uploadedAt;

  final DateTime? deletedAt;

  final bool isFavorite;

  const DocumentModel({
    required this.id,
    required this.title,
    required this.category,
    required this.fileType,
    required this.localPath,
    required this.connectedSpace,
    required this.uploadedAt,
    this.deletedAt,
    this.isFavorite = false,
  });

  bool get isDeleted {
    return deletedAt != null;
  }

  DocumentModel copyWith({
    String? id,
    String? title,
    String? category,
    String? fileType,
    String? localPath,
    String? connectedSpace,
    DateTime? uploadedAt,
    DateTime? deletedAt,
    bool? isFavorite,
    bool clearDeletedAt = false,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      fileType: fileType ?? this.fileType,
      localPath: localPath ?? this.localPath,
      connectedSpace:
          connectedSpace ?? this.connectedSpace,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      deletedAt:
          clearDeletedAt
              ? null
              : deletedAt ?? this.deletedAt,
      isFavorite:
          isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'fileType': fileType,
      'localPath': localPath,
      'connectedSpace': connectedSpace,
      'uploadedAt':
          uploadedAt.toIso8601String(),
      'deletedAt':
          deletedAt?.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }

  factory DocumentModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return DocumentModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      fileType: map['fileType'] ?? '',
      localPath: map['localPath'] ?? '',
      connectedSpace:
          map['connectedSpace'] ?? '',
      uploadedAt: DateTime.tryParse(
            map['uploadedAt'] ?? '',
          ) ??
          DateTime.now(),
      deletedAt: map['deletedAt'] == null
          ? null
          : DateTime.tryParse(
              map['deletedAt'],
            ),
      isFavorite:
          map['isFavorite'] ?? false,
    );
  }
}