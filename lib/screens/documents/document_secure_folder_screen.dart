import 'package:flutter/material.dart';

import '../../services/documents_service.dart';
import '../../widgets/document_card.dart';
import '../../widgets/document_empty_folder_card.dart';

class DocumentSecureFolderScreen extends StatefulWidget {
  const DocumentSecureFolderScreen({
    super.key,
  });

  @override
  State<DocumentSecureFolderScreen> createState() =>
      _DocumentSecureFolderScreenState();
}

class _DocumentSecureFolderScreenState
    extends State<DocumentSecureFolderScreen> {
  final documentsService = DocumentsService.instance;

  @override
  Widget build(BuildContext context) {
    final secureDocuments = documentsService.documents.where((doc) {
      return doc.category.toLowerCase().contains('secure') ||
          doc.category.toLowerCase().contains('identity') ||
          doc.category.toLowerCase().contains('legal') ||
          doc.category.toLowerCase().contains('medical') ||
          doc.category.toLowerCase().contains('tax');
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
                  title: 'No Secure Documents Yet',
                  subtitle:
                      'Identity, legal, tax, and medical documents will appear here.',
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