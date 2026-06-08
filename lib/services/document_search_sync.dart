import '../models/document_model.dart';
import '../models/search_result_item.dart';

import 'global_search_service.dart';

class DocumentSearchSync {
  DocumentSearchSync._();

  static void syncDocument(
    DocumentModel document,
  ) {
    if (document.isDeleted) {
      removeDocument(document.id);
      return;
    }

    GlobalSearchService.instance.register(
      SearchResultItem(
        id: 'document_${document.id}',
        title: document.title,
        subtitle: document.category,
        content:
            '${document.title} ${document.category} ${document.fileType} ${document.connectedSpace}',
        sourceType: 'document',
        spaceId: 'documents',
        spaceName: 'Documents',
        createdAt: document.uploadedAt,
      ),
    );
  }

  static void removeDocument(
    String id,
  ) {
    GlobalSearchService.instance.remove(
      'document_$id',
    );
  }
}