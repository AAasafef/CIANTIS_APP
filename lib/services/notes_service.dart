import 'package:flutter/material.dart';

import '../models/note_item.dart';

import 'activity_log_service.dart';
import 'note_search_sync.dart';

class NotesService extends ChangeNotifier {
  static final NotesService instance =
      NotesService._internal();

  NotesService._internal();

  Future<void> initialize() async {}

  final List<NoteItem> _notes = [];

  List<NoteItem> get notes {
    final copy = _notes.where((note) {
      return !note.isDeleted;
    }).toList();

    copy.sort(
      (a, b) => b.updatedAt.compareTo(a.updatedAt),
    );

    return copy;
  }

  List<NoteItem> get deletedNotes {
    final copy = _notes.where((note) {
      return note.isDeleted;
    }).toList();

    copy.sort((a, b) {
      final aDeleted = a.deletedAt ??
          DateTime.fromMillisecondsSinceEpoch(0);
      final bDeleted = b.deletedAt ??
          DateTime.fromMillisecondsSinceEpoch(0);

      return bDeleted.compareTo(aDeleted);
    });

    return copy;
  }

  List<NoteItem> notesForSpace(String spaceId) {
    return notes.where((note) {
      return note.spaceId == spaceId;
    }).toList();
  }

  List<NoteItem> notesForItem(String itemId) {
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

    final note = NoteItem(
      id: now.microsecondsSinceEpoch.toString(),
      title: title,
      body: body,
      spaceId: spaceId,
      spaceName: spaceName,
      linkedItemId: linkedItemId,
      createdAt: now,
      updatedAt: now,
    );

    _notes.insert(0, note);

    NoteSearchSync.syncNote(note);

    await ActivityLogService.instance.addActivity(
      title: 'Note Created',
      description: title,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: 'created',
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

    final oldNote = _notes[index];

    final updatedNote = oldNote.copyWith(
      title: title,
      body: body,
      updatedAt: DateTime.now(),
    );

    _notes[index] = updatedNote;

    NoteSearchSync.syncNote(updatedNote);

    await ActivityLogService.instance.addActivity(
      title: 'Note Updated',
      description: title,
      spaceId: oldNote.spaceId,
      spaceName: oldNote.spaceName,
      actionType: 'edited',
    );

    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    final index = _notes.indexWhere(
      (note) => note.id == id,
    );

    if (index == -1) return;

    final oldNote = _notes[index];

    final deletedNote = oldNote.copyWith(
      deletedAt: DateTime.now(),
    );

    _notes[index] = deletedNote;

    NoteSearchSync.syncNote(deletedNote);

    await ActivityLogService.instance.addActivity(
      title: 'Note Deleted',
      description: oldNote.title,
      spaceId: oldNote.spaceId,
      spaceName: oldNote.spaceName,
      actionType: 'deleted',
    );

    notifyListeners();
  }

  Future<void> restoreNote(String id) async {
    final index = _notes.indexWhere(
      (note) => note.id == id,
    );

    if (index == -1) return;

    final oldNote = _notes[index];

    final restoredNote = oldNote.copyWith(
      clearDeletedAt: true,
      updatedAt: DateTime.now(),
    );

    _notes[index] = restoredNote;

    NoteSearchSync.syncNote(restoredNote);

    await ActivityLogService.instance.addActivity(
      title: 'Note Restored',
      description: restoredNote.title,
      spaceId: restoredNote.spaceId,
      spaceName: restoredNote.spaceName,
      actionType: 'restored',
    );

    notifyListeners();
  }

  Future<void> permanentlyDeleteNote(String id) async {
    NoteSearchSync.removeNote(id);

    _notes.removeWhere(
      (note) => note.id == id,
    );

    notifyListeners();
  }

  Future<void> emptyTrash() async {
    for (final note in deletedNotes) {
      NoteSearchSync.removeNote(note.id);
    }

    _notes.removeWhere(
      (note) => note.isDeleted,
    );

    notifyListeners();
  }

  List<NoteItem> search(String query) {
    if (query.trim().isEmpty) {
      return notes;
    }

    final q = query.trim().toLowerCase();

    return notes.where((note) {
      return note.title.toLowerCase().contains(q) ||
          note.body.toLowerCase().contains(q);
    }).toList();
  }
}