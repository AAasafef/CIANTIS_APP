import 'package:flutter/material.dart';

import '../models/document_model.dart';

class DocumentsService
    extends ChangeNotifier {

  static final DocumentsService
      instance =
      DocumentsService._internal();

  DocumentsService._internal();

  final List<DocumentModel>
      _documents = [];

  List<DocumentModel>
      get documents =>
          _documents;

  void addDocument({
    required String title,
    required String category,
    required String fileType,
    required String localPath,
    required String connectedSpace,
  }) {

    _documents.insert(
      0,

      DocumentModel(
        id:
            DateTime.now()
                .millisecondsSinceEpoch
                .toString(),

        title: title,

        category: category,

        fileType: fileType,

        localPath: localPath,

        connectedSpace:
            connectedSpace,

        uploadedAt:
            DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void removeDocument(
    String id,
  ) {

    _documents.removeWhere(
      (doc) =>
          doc.id == id,
    );

    notifyListeners();
  }

  List<DocumentModel>
      documentsByCategory(
    String category,
  ) {

    return _documents
        .where(
          (doc) =>
              doc.category ==
              category,
        )
        .toList();
  }

  List<DocumentModel>
      documentsBySpace(
    String space,
  ) {

    return _documents
        .where(
          (doc) =>
              doc.connectedSpace ==
              space,
        )
        .toList();
  }
}