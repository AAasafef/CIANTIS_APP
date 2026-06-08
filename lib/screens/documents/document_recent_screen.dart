import 'package:flutter/material.dart';

import '../../services/documents_service.dart';
import '../../widgets/document_card.dart';
import '../../widgets/document_empty_folder_card.dart';

class DocumentRecentScreen extends StatefulWidget {
  const DocumentRecentScreen({
    super.key,
  });

  @override
  State<DocumentRecentScreen> createState() =>
      _DocumentRecentScreenState();
}

class _DocumentRecentScreenState
    extends State<DocumentRecentScreen> {
  final DocumentsService documentsService =
      DocumentsService.instance;

  @override
  Widget build(BuildContext context) {
    final recent =
        documentsService.recentDocuments;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4EFE8),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF2D241D),
        ),
        title: const Text(
          'Recent Documents',
          style: TextStyle(
            color: Color(0xFF2D241D),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: recent.isEmpty
            ? const Center(
                child: DocumentEmptyFolderCard(
                  title: 'No Recent Documents',
                  subtitle:
                      'Recently uploaded documents will appear here.',
                ),
              )
            : ListView.builder(
                physics:
                    const BouncingScrollPhysics(),
                itemCount: recent.length,
                itemBuilder:
                    (context, index) {
                  return DocumentCard(
                    document: recent[index],
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