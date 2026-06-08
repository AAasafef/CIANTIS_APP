import '../models/note_item.dart';
import '../models/search_result_item.dart';

import 'global_search_service.dart';

class NoteSearchSync {
  NoteSearchSync._();

  static void syncNote(
    NoteItem note,
  ) {
    if (note.isDeleted) {
      GlobalSearchService.instance.remove(
        'note_${note.id}',
      );

      return;
    }

    GlobalSearchService.instance.register(
      SearchResultItem(
        id: 'note_${note.id}',
        title: note.title,
        subtitle: note.spaceName,
        content: note.body,
        sourceType: 'note',
        spaceId: note.spaceId,
        spaceName: note.spaceName,
        createdAt: note.updatedAt,
      ),
    );
  }

  static void removeNote(
    String id,
  ) {
    GlobalSearchService.instance.remove(
      'note_$id',
    );
  }
}