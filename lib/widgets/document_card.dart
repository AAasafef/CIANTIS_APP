import 'package:flutter/material.dart';

import '../models/document_model.dart';
import '../screens/documents/document_viewer_screen.dart';
import '../services/documents_service.dart';

class DocumentCard extends StatelessWidget {
  final DocumentModel document;
  final VoidCallback onUpdated;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DocumentViewerScreen(
              document: document,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF4EFE8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: _buildPreviewIcon(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D241D),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    document.category,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(.55),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    document.fileType,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFB08D6D),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () async {
                    await DocumentsService.instance.toggleFavorite(
                      document.id,
                    );

                    onUpdated();
                  },
                  icon: Icon(
                    document.isFavorite
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    color: document.isFavorite
                        ? const Color(0xFFB08D6D)
                        : const Color(0xFF8B7D72),
                  ),
                ),
                PopupMenuButton<String>(
                  color: Colors.white,
                  onSelected: (value) async {
                    if (value == 'favorite') {
                      await DocumentsService.instance.toggleFavorite(
                        document.id,
                      );

                      onUpdated();
                    }

                    if (value == 'delete') {
                      await DocumentsService.instance.deleteDocument(
                        document,
                      );

                      onUpdated();
                    }

                    if (value == 'rename') {
                      _showRenameDialog(context);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 'favorite',
                        child: Text(
                          document.isFavorite
                              ? 'Remove Favorite'
                              : 'Add Favorite',
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'rename',
                        child: Text('Rename'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewIcon() {
    final extension = document.fileType.toLowerCase();

    if (extension.contains('pdf')) {
      return const Icon(
        Icons.picture_as_pdf_outlined,
        color: Color(0xFF6E5846),
        size: 30,
      );
    }

    if (extension.contains('jpg') ||
        extension.contains('jpeg') ||
        extension.contains('png') ||
        extension.contains('image')) {
      return const Icon(
        Icons.image_outlined,
        color: Color(0xFF6E5846),
        size: 30,
      );
    }

    if (extension.contains('doc') || extension.contains('text')) {
      return const Icon(
        Icons.article_outlined,
        color: Color(0xFF6E5846),
        size: 30,
      );
    }

    if (extension.contains('sheet') ||
        extension.contains('xls') ||
        extension.contains('csv')) {
      return const Icon(
        Icons.table_chart_outlined,
        color: Color(0xFF6E5846),
        size: 30,
      );
    }

    return const Icon(
      Icons.description_outlined,
      color: Color(0xFF6E5846),
      size: 30,
    );
  }

  void _showRenameDialog(BuildContext context) {
    final controller = TextEditingController(
      text: document.title,
    );

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          title: const Text('Rename Document'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter new name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await DocumentsService.instance.renameDocument(
                  document: document,
                  newTitle: controller.text,
                );

                if (context.mounted) {
                  Navigator.pop(context);
                }

                onUpdated();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}