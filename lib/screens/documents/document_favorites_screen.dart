import 'package:flutter/material.dart';

import '../../services/documents_service.dart';
import '../../widgets/document_card.dart';
import '../../widgets/document_empty_folder_card.dart';

class DocumentFavoritesScreen extends StatefulWidget {
  const DocumentFavoritesScreen({
    super.key,
  });

  @override
  State<DocumentFavoritesScreen> createState() =>
      _DocumentFavoritesScreenState();
}

class _DocumentFavoritesScreenState
    extends State<DocumentFavoritesScreen> {
  final DocumentsService documentsService =
      DocumentsService.instance;

  @override
  Widget build(BuildContext context) {
    final favorites =
        documentsService.favoriteDocuments;

    favorites.sort(
      (a, b) => b.uploadedAt.compareTo(
        a.uploadedAt,
      ),
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
          'Favorites',
          style: TextStyle(
            color: Color(0xFF2D241D),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: favorites.isEmpty
            ? const Center(
                child: DocumentEmptyFolderCard(
                  title: 'No Favorites Yet',
                  subtitle:
                      'Star important documents to access them quickly.',
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return DocumentCard(
                    document: favorites[index],
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