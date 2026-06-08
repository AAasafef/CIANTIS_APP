import 'package:flutter/material.dart';

import '../../services/documents_service.dart';

import '../../widgets/document_card.dart';
import '../../widgets/document_empty_folder_card.dart';

class EmptyDocumentFolderScreen extends StatefulWidget {
  final String folderTitle;

  const EmptyDocumentFolderScreen({
    super.key,
    required this.folderTitle,
  });

  @override
  State<EmptyDocumentFolderScreen> createState() =>
      _EmptyDocumentFolderScreenState();
}

class _EmptyDocumentFolderScreenState
    extends State<EmptyDocumentFolderScreen> {
  final documentsService = DocumentsService.instance;

  bool _matchesFolder(String docCategory) {
    final doc = docCategory.toLowerCase();
    final folder = widget.folderTitle.toLowerCase();

    if (doc == folder) return true;
    if (doc.contains(folder)) return true;

    if (folder == 'school documents' &&
        doc.contains('school')) {
      return true;
    }

    if (folder == 'medical records' &&
        doc.contains('medical')) {
      return true;
    }

    if (folder == 'tax documents' &&
        doc.contains('tax')) {
      return true;
    }

    if (folder == 'business' &&
        doc.contains('business')) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final documents = documentsService.documents.where((doc) {
      return _matchesFolder(doc.category);
    }).toList();

    documents.sort(
      (a, b) => b.uploadedAt.compareTo(a.uploadedAt),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBF8F4),
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
                  Expanded(
                    child: Text(
                      widget.folderTitle,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -.8,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                '${documents.length} document${documents.length == 1 ? '' : 's'}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.4,
                  color: Color(0xFF8B7D72),
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: documents.isEmpty
                    ? const Center(
                        child: DocumentEmptyFolderCard(
                          title: 'No Documents Yet',
                          subtitle:
                              'Documents added to this category will appear here automatically.',
                        ),
                      )
                    : ListView.builder(
                        physics:
                            const BouncingScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          return DocumentCard(
                            document: documents[index],
                            onUpdated: () {
                              setState(() {});
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}