import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/document_model.dart';

import 'activity_log_service.dart';
import 'document_search_sync.dart';
import 'notification_service.dart';

class DocumentsService extends ChangeNotifier {
  static final DocumentsService instance =
      DocumentsService._internal();

  DocumentsService._internal();

  static const String _storageKey = 'ciantis_documents';

  final List<DocumentModel> _documents = [];

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    final prefs = await SharedPreferences.getInstance();

    final rawList = prefs.getStringList(_storageKey) ?? [];

    _documents
      ..clear()
      ..addAll(
        rawList.map((raw) {
          return DocumentModel.fromMap(
            jsonDecode(raw),
          );
        }),
      );

    _initialized = true;

    notifyListeners();
  }

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();

    final rawList = _documents.map((doc) {
      return jsonEncode(
        doc.toMap(),
      );
    }).toList();

    await prefs.setStringList(
      _storageKey,
      rawList,
    );
  }

  List<DocumentModel> get documents {
    return _documents.where((doc) {
      return !doc.isDeleted;
    }).toList();
  }

  List<DocumentModel> get deletedDocuments {
    return _documents.where((doc) {
      return doc.isDeleted;
    }).toList();
  }

  List<DocumentModel> get favoriteDocuments {
    return documents.where((doc) {
      return doc.isFavorite;
    }).toList();
  }

  List<DocumentModel> get recentDocuments {
    final docs = [...documents];

    docs.sort(
      (a, b) => b.uploadedAt.compareTo(
        a.uploadedAt,
      ),
    );

    return docs.take(20).toList();
  }

  Future<void> addDocument({
    required String title,
    required String category,
    required String fileType,
    required String localPath,
    required String connectedSpace,
  }) async {
    await _ensureInitialized();

    final document = DocumentModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      category: category,
      fileType: fileType,
      localPath: localPath,
      connectedSpace: connectedSpace,
      uploadedAt: DateTime.now(),
    );

    _documents.insert(
      0,
      document,
    );

    DocumentSearchSync.syncDocument(
      document,
    );

    await _save();

    await NotificationService.instance.addNotification(
      title: 'Document Saved',
      message: '$title added to $category',
      type: 'document',
      spaceId: 'documents',
      spaceName: 'Documents',
    );

    notifyListeners();
  }

  Future<void> renameDocument({
    required DocumentModel document,
    required String newTitle,
  }) async {
    await _ensureInitialized();

    final title = newTitle.trim();

    if (title.isEmpty) return;

    final index = _documents.indexWhere(
      (doc) => doc.id == document.id,
    );

    if (index == -1) return;

    final oldTitle = document.title;

    _documents[index] = _documents[index].copyWith(
      title: title,
    );

    DocumentSearchSync.syncDocument(
      _documents[index],
    );

    await _save();

    await ActivityLogService.instance.addActivity(
      title: 'Document Renamed',
      description: '$oldTitle → $title',
      spaceId: 'documents',
      spaceName: 'Documents',
      actionType: 'edited',
    );

    notifyListeners();
  }

  Future<void> toggleFavorite(
    String id,
  ) async {
    await _ensureInitialized();

    final index = _documents.indexWhere(
      (doc) => doc.id == id,
    );

    if (index == -1) return;

    _documents[index] = _documents[index].copyWith(
      isFavorite: !_documents[index].isFavorite,
    );

    DocumentSearchSync.syncDocument(
      _documents[index],
    );

    await _save();

    notifyListeners();
  }

  Future<void> removeDocument(String id) async {
    await _ensureInitialized();

    final index = _documents.indexWhere(
      (doc) => doc.id == id,
    );

    if (index == -1) return;

    _documents[index] = _documents[index].copyWith(
      deletedAt: DateTime.now(),
    );

    DocumentSearchSync.removeDocument(
      id,
    );

    await _save();

    notifyListeners();
  }

  Future<void> deleteDocument(DocumentModel document) async {
    await removeDocument(
      document.id,
    );
  }

  Future<void> restoreDocument(DocumentModel document) async {
    await _ensureInitialized();

    final index = _documents.indexWhere(
      (doc) => doc.id == document.id,
    );

    if (index == -1) return;

    _documents[index] = _documents[index].copyWith(
      clearDeletedAt: true,
    );

    DocumentSearchSync.syncDocument(
      _documents[index],
    );

    await _save();

    notifyListeners();
  }

  Future<void> permanentlyDeleteDocument(DocumentModel document) async {
    await _ensureInitialized();

    _documents.removeWhere(
      (doc) => doc.id == document.id,
    );

    DocumentSearchSync.removeDocument(
      document.id,
    );

    await _save();

    notifyListeners();
  }

  Future<void> emptyTrash() async {
    await _ensureInitialized();

    for (final document in deletedDocuments) {
      DocumentSearchSync.removeDocument(
        document.id,
      );
    }

    _documents.removeWhere(
      (doc) => doc.isDeleted,
    );

    await _save();

    notifyListeners();
  }

  DocumentModel? getDocumentById(String id) {
    try {
      return _documents.firstWhere(
        (doc) => doc.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  List<DocumentModel> searchDocuments(String query) {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      return documents;
    }

    return documents.where((doc) {
      return doc.title.toLowerCase().contains(q) ||
          doc.category.toLowerCase().contains(q) ||
          doc.fileType.toLowerCase().contains(q) ||
          doc.connectedSpace.toLowerCase().contains(q);
    }).toList();
  }
}