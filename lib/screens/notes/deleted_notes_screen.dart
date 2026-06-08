import 'package:flutter/material.dart';

import '../../models/note_item.dart';
import '../../services/notes_service.dart';

class DeletedNotesScreen extends StatefulWidget {
  const DeletedNotesScreen({super.key});

  @override
  State<DeletedNotesScreen> createState() => _DeletedNotesScreenState();
}

class _DeletedNotesScreenState extends State<DeletedNotesScreen> {
  final NotesService notesService = NotesService.instance;

  @override
  Widget build(BuildContext context) {
    final deletedNotes = notesService.deletedNotes;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Deleted Notes',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -1,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await notesService.emptyTrash();
                      setState(() {});
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.delete_forever_outlined,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              if (deletedNotes.isEmpty)
                const _EmptyDeletedNotes()
              else
                Column(
                  children: deletedNotes.map((note) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _DeletedNoteTile(
                        note: note,
                        onRestore: () async {
                          await notesService.restoreNote(note.id);
                          setState(() {});
                        },
                        onDeleteForever: () async {
                          await notesService.permanentlyDeleteNote(note.id);
                          setState(() {});
                        },
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyDeletedNotes extends StatelessWidget {
  const _EmptyDeletedNotes();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Text(
        'No deleted notes.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF2D241D),
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class _DeletedNoteTile extends StatelessWidget {
  final NoteItem note;
  final VoidCallback onRestore;
  final VoidCallback onDeleteForever;

  const _DeletedNoteTile({
    required this.note,
    required this.onRestore,
    required this.onDeleteForever,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.edit_note_rounded,
            color: Color(0xFF6E5846),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              note.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF2D241D),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          IconButton(
            onPressed: onRestore,
            icon: const Icon(Icons.restore_rounded),
          ),
          IconButton(
            onPressed: onDeleteForever,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}