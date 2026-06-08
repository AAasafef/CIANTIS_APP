import 'package:flutter/material.dart';

import '../../services/documents_service.dart';
import '../../widgets/document_card.dart';
import '../../widgets/document_empty_folder_card.dart';

class DocumentSecureDocumentsScreen extends StatefulWidget {
  const DocumentSecureDocumentsScreen({
    super.key,
  });

  @override
  State<DocumentSecureDocumentsScreen> createState() =>
      _DocumentSecureDocumentsScreenState();
}

class _DocumentSecureDocumentsScreenState
    extends State<DocumentSecureDocumentsScreen> {
  final DocumentsService documentsService =
      DocumentsService.instance;

  @override
  Widget build(BuildContext context) {
    final secureDocuments =
        documentsService.documents.where((doc) {
      final category = doc.category.toLowerCase();

      return category.contains('secure') ||
          category.contains('identity') ||
          category.contains('legal') ||
          category.contains('medical') ||
          category.contains('tax');
    }).toList();

    secureDocuments.sort(
      (a, b) => b.uploadedAt.compareTo(a.uploadedAt),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4EFE8),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF2D241D),
        ),
        title: const Text(
          'Secure Documents',
          style: TextStyle(
            color: Color(0xFF2D241D),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: secureDocuments.isEmpty
            ? const Center(
                child: DocumentEmptyFolderCard(
                  title: 'No Secure Documents',
                  subtitle:
                      'Identity, legal, medical, and tax documents will appear here.',
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: secureDocuments.length,
                itemBuilder: (context, index) {
                  return DocumentCard(
                    document: secureDocuments[index],
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