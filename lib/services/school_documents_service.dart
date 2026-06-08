import 'package:flutter/material.dart';

import '../models/school_document_model.dart';

class SchoolDocumentsService
    extends ChangeNotifier {

  static final SchoolDocumentsService
      instance =
      SchoolDocumentsService._internal();

  SchoolDocumentsService._internal();

  final List<SchoolDocumentModel>
      _documents = [];

  List<SchoolDocumentModel>
      get documents =>
          _documents;

  void addDocument({
    required String title,
    required String category,
    required String fileType,
    required String localPath,
  }) {

    _documents.insert(
      0,

      SchoolDocumentModel(
        id:
            DateTime.now()
                .millisecondsSinceEpoch
                .toString(),

        title: title,

        category: category,

        fileType: fileType,

        localPath: localPath,

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

  List<SchoolDocumentModel>
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
}