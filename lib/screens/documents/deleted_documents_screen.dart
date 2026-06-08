import 'package:flutter/material.dart';

import '../../models/document_model.dart';
import '../../services/documents_service.dart';

class DeletedDocumentsScreen extends StatefulWidget {
  const DeletedDocumentsScreen({
    super.key,
  });

  @override
  State<DeletedDocumentsScreen> createState() =>
      _DeletedDocumentsScreenState();
}

class _DeletedDocumentsScreenState
    extends State<DeletedDocumentsScreen> {
  final DocumentsService documentsService =
      DocumentsService.instance;

  Future<void> _restore(DocumentModel document) async {
    await documentsService.restoreDocument(document);

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF2D241D),
        content: Text('Document restored'),
      ),
    );
  }

  Future<void> _deleteForever(DocumentModel document) async {
    await documentsService.permanentlyDeleteDocument(document);

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF2D241D),
        content: Text('Document permanently deleted'),
      ),
    );
  }

  Future<void> _emptyTrash() async {
    await documentsService.emptyTrash();

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF2D241D),
        content: Text('Trash emptied'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deletedDocuments =
        documentsService.deletedDocuments;

    deletedDocuments.sort((a, b) {
      final aDeleted =
          a.deletedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDeleted =
          b.deletedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

      return bDeleted.compareTo(aDeleted);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            40,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFE2D8CD),
                          width: .7,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trash',
                          style: TextStyle(
                            fontSize: 40,
                            height: .98,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -1,
                            color: Color(0xFF2D241D),
                          ),
                        ),
                        SizedBox(height: 9),
                        Text(
                          'DELETED DOCUMENTS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3,
                            color: Color(0xFF8B7D72),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: deletedDocuments.isEmpty
                        ? null
                        : _emptyTrash,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFE2D8CD),
                          width: .7,
                        ),
                      ),
                      child: Icon(
                        Icons.delete_forever_outlined,
                        color: deletedDocuments.isEmpty
                            ? const Color(0xFFB8AEA5)
                            : const Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              if (deletedDocuments.isEmpty)
                const _EmptyTrashState()
              else
                Column(
                  children: deletedDocuments.map((document) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 10),
                      child: _DeletedDocumentTile(
                        document: document,
                        onRestore: () {
                          _restore(document);
                        },
                        onDeleteForever: () {
                          _deleteForever(document);
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

class _EmptyTrashState extends StatelessWidget {
  const _EmptyTrashState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        34,
        24,
        34,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.88),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFF4EFE8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.delete_outline_rounded,
              color: Color(0xFF6E5846),
              size: 28,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Trash is empty',
            style: TextStyle(
              color: Color(0xFF2D241D),
              fontSize: 22,
              fontWeight: FontWeight.w300,
              letterSpacing: -.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Deleted documents will appear here so you can restore them or remove them forever.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(.55),
              fontSize: 13,
              fontWeight: FontWeight.w300,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _DeletedDocumentTile extends StatelessWidget {
  final DocumentModel document;
  final VoidCallback onRestore;
  final VoidCallback onDeleteForever;

  const _DeletedDocumentTile({
    required this.document,
    required this.onRestore,
    required this.onDeleteForever,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.035),
            blurRadius: 16,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF4EFE8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _iconForFile(document.fileType),
              color: const Color(0xFF6E5846),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF2D241D),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${document.category} • ${document.fileType.toUpperCase()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.55),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Deleted ${_formatTime(document.deletedAt ?? document.uploadedAt)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF8B7D72),
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRestore,
            visualDensity: VisualDensity.compact,
            splashRadius: 18,
            icon: const Icon(
              Icons.restore_rounded,
              color: Color(0xFF6E5846),
              size: 20,
            ),
          ),
          IconButton(
            onPressed: onDeleteForever,
            visualDensity: VisualDensity.compact,
            splashRadius: 18,
            icon: const Icon(
              Icons.close_rounded,
              color: Color(0xFF8B7D72),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  static IconData _iconForFile(String fileType) {
    final type = fileType.toLowerCase();

    if (type.contains('pdf')) {
      return Icons.picture_as_pdf_outlined;
    }

    if (type.contains('jpg') ||
        type.contains('jpeg') ||
        type.contains('png') ||
        type.contains('image')) {
      return Icons.image_outlined;
    }

    if (type.contains('doc')) {
      return Icons.description_outlined;
    }

    return Icons.folder_outlined;
  }

  static String _formatTime(DateTime date) {
    final hour = date.hour == 0
        ? 12
        : date.hour > 12
            ? date.hour - 12
            : date.hour;

    final minute = date.minute.toString().padLeft(
          2,
          '0',
        );

    final period = date.hour < 12 ? 'AM' : 'PM';

    return '${date.month}/${date.day}/${date.year} · $hour:$minute $period';
  }
}
