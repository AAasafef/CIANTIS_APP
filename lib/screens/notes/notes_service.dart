import 'package:flutter/material.dart';

import '../models/note_item.dart';

class NotesService extends ChangeNotifier {
  static final NotesService instance =
      NotesService._internal();

  NotesService._internal();

  final List<NoteItem> _notes = [];

  List<NoteItem> get notes {
    final copy = [..._notes];

    copy.sort(
      (a, b) =>
          b.updatedAt.compareTo(a.updatedAt),
    );

    return copy;
  }

  List<NoteItem> notesForSpace(
    String spaceId,
  ) {
    return notes.where((note) {
      return note.spaceId == spaceId;
    }).toList();
  }

  List<NoteItem> notesForItem(
    String itemId,
  ) {
    return notes.where((note) {
      return note.linkedItemId == itemId;
    }).toList();
  }

  Future<void> createNote({
    required String title,
    required String body,
    required String spaceId,
    required String spaceName,
    String? linkedItemId,
  }) async {
    final now = DateTime.now();

    _notes.insert(
      0,
      NoteItem(
        id: now.microsecondsSinceEpoch
            .toString(),
        title: title,
        body: body,
        spaceId: spaceId,
        spaceName: spaceName,
        linkedItemId: linkedItemId,
        createdAt: now,
        updatedAt: now,
      ),
    );

    notifyListeners();
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String body,
  }) async {
    final index = _notes.indexWhere(
      (note) => note.id == id,
    );

    if (index == -1) return;

    final note = _notes[index];

    _notes[index] = NoteItem(
      id: note.id,
      title: title,
      body: body,
      spaceId: note.spaceId,
      spaceName: note.spaceName,
      linkedItemId: note.linkedItemId,
      createdAt: note.createdAt,
      updatedAt: DateTime.now(),
    );

    notifyListeners();
  }

  Future<void> deleteNote(
    String id,
  ) async {
    _notes.removeWhere(
      (note) => note.id == id,
    );

    notifyListeners();
  }

  List<NoteItem> search(
    String query,
  ) {
    if (query.trim().isEmpty) {
      return notes;
    }

    final q =
        query.trim().toLowerCase();

    return notes.where((note) {
      return note.title
              .toLowerCase()
              .contains(q) ||
          note.body
              .toLowerCase()
              .contains(q);
    }).toList();
  }
}