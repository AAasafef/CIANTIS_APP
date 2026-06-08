import 'package:flutter/material.dart';

import '../../services/documents_service.dart';
import '../../widgets/document_card.dart';
import '../../widgets/document_empty_folder_card.dart';

class DocumentHiddenDocumentsScreen
    extends StatefulWidget {
  const DocumentHiddenDocumentsScreen({
    super.key,
  });

  @override
  State<DocumentHiddenDocumentsScreen>
      createState() =>
          _DocumentHiddenDocumentsScreenState();
}

class _DocumentHiddenDocumentsScreenState
    extends State<DocumentHiddenDocumentsScreen> {
  final DocumentsService documentsService =
      DocumentsService.instance;

  @override
  Widget build(BuildContext context) {
    final hiddenDocuments =
        documentsService.documents.where((doc) {
      final category =
          doc.category.toLowerCase();

      return category.contains('hidden') ||
          category.contains('private');
    }).toList();

    hiddenDocuments.sort(
      (a, b) =>
          b.uploadedAt.compareTo(
        a.uploadedAt,
      ),
    );

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4EFE8),
      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF4EFE8),
        elevation: 0,
        iconTheme:
            const IconThemeData(
          color: Color(0xFF2D241D),
        ),
        title: const Text(
          'Hidden Documents',
          style: TextStyle(
            color: Color(0xFF2D241D),
            fontWeight:
                FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: hiddenDocuments.isEmpty
            ? const Center(
                child:
                    DocumentEmptyFolderCard(
                  title:
                      'No Hidden Documents',
                  subtitle:
                      'Hidden documents will appear here.',
                ),
              )
            : ListView.builder(
                physics:
                    const BouncingScrollPhysics(),
                itemCount:
                    hiddenDocuments.length,
                itemBuilder:
                    (context, index) {
                  return DocumentCard(
                    document:
                        hiddenDocuments[
                            index],
                    onUpdated: () {
                      setState(() {});
                    },
                  );
                },
              ),
      ),
    );
  }
}