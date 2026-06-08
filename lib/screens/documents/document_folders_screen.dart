import 'package:flutter/material.dart';

import '../../services/documents_service.dart';

import '../../widgets/document_ai_banner.dart';
import '../../widgets/document_category_stats_card.dart';
import '../../widgets/document_folder_card.dart';
import '../../widgets/document_quick_action_card.dart';
import '../../widgets/document_section_title.dart';
import '../../widgets/document_storage_card.dart';
import '../../widgets/document_sync_status_card.dart';
import '../../widgets/document_vault_header.dart';

import 'document_ai_processing_screen.dart';
import 'document_favorites_screen.dart';
import 'document_hidden_folder_screen.dart';
import 'document_import_sources_screen.dart';
import 'document_recent_screen.dart';
import 'document_scanning_screen.dart';
import 'document_secure_folder_screen.dart';
import 'document_trash_screen.dart';
import 'empty_document_folder_screen.dart';

class DocumentFoldersScreen extends StatefulWidget {
  const DocumentFoldersScreen({
    super.key,
  });

  @override
  State<DocumentFoldersScreen> createState() =>
      _DocumentFoldersScreenState();
}

class _DocumentFoldersScreenState
    extends State<DocumentFoldersScreen> {
  final DocumentsService documentsService =
      DocumentsService.instance;

  int _countByCategory(String category) {
    final docs = documentsService.documents;

    return docs.where((doc) {
      final docCategory =
          doc.category.toLowerCase();
      final selected =
          category.toLowerCase();

      if (docCategory == selected) return true;
      if (docCategory.contains(selected)) return true;

      if (selected == 'business' &&
          docCategory.contains('business')) {
        return true;
      }

      if (selected == 'school documents' &&
          docCategory.contains('school')) {
        return true;
      }

      if (selected == 'medical records' &&
          docCategory.contains('medical')) {
        return true;
      }

      if (selected == 'tax documents' &&
          docCategory.contains('tax')) {
        return true;
      }

      return false;
    }).length;
  }

  int _countByFileType(String type) {
    final docs = documentsService.documents;

    return docs.where((doc) {
      return doc.fileType.toUpperCase() ==
          type.toUpperCase();
    }).length;
  }

  int _secureCount() {
    return documentsService.documents.where((doc) {
      final category = doc.category.toLowerCase();

      return category.contains('secure') ||
          category.contains('identity') ||
          category.contains('legal') ||
          category.contains('medical') ||
          category.contains('tax');
    }).length;
  }

  int _hiddenCount() {
    return documentsService.documents.where((doc) {
      final category = doc.category.toLowerCase();

      return category.contains('hidden') ||
          category.contains('private');
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final totalDocuments =
        documentsService.documents.length;

    final pdfCount = _countByFileType('PDF');

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  const Expanded(
                    child: Text(
                      'Folders',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -.8,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              const DocumentVaultHeader(),

              const SizedBox(height: 22),

              const DocumentStorageCard(
                usedStorage: 4.8,
                totalStorage: 25,
              ),

              const SizedBox(height: 18),

              const DocumentSyncStatusCard(
                synced: true,
              ),

              const SizedBox(height: 22),

              const DocumentAiBanner(),

              const SizedBox(height: 30),

              const DocumentSectionTitle(
                title: 'Vault Statistics',
              ),

              const SizedBox(height: 18),

              SizedBox(
                height: 190,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics:
                      const BouncingScrollPhysics(),
                  children: [
                    DocumentCategoryStatsCard(
                      title: 'Total Files',
                      amount: '$totalDocuments',
                      icon: Icons.folder_copy_outlined,
                    ),
                    const SizedBox(width: 16),
                    DocumentCategoryStatsCard(
                      title: 'PDF Files',
                      amount: '$pdfCount',
                      icon: Icons.picture_as_pdf_outlined,
                    ),
                    const SizedBox(width: 16),
                    DocumentCategoryStatsCard(
                      title: 'Favorites',
                      amount:
                          '${documentsService.favoriteDocuments.length}',
                      icon: Icons.star_rounded,
                    ),
                    const SizedBox(width: 16),
                    DocumentCategoryStatsCard(
                      title: 'Secure',
                      amount: '${_secureCount()}',
                      icon: Icons.lock_outline_rounded,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const DocumentSectionTitle(
                title: 'Quick Actions',
              ),

              const SizedBox(height: 18),

              SizedBox(
                height: 185,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics:
                      const BouncingScrollPhysics(),
                  children: [
                    DocumentQuickActionCard(
                      title: 'Scan Receipt',
                      subtitle:
                          'Quickly scan and organize receipts.',
                      icon:
                          Icons.receipt_long_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DocumentScanningScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    DocumentQuickActionCard(
                      title: 'Import Files',
                      subtitle:
                          'Import from device, cloud, or email.',
                      icon:
                          Icons.cloud_upload_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DocumentImportSourcesScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    DocumentQuickActionCard(
                      title: 'AI Processing',
                      subtitle:
                          'Watch intelligent document analysis.',
                      icon:
                          Icons.auto_awesome_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DocumentAiProcessingScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    DocumentQuickActionCard(
                      title: 'Secure Vault',
                      subtitle:
                          'Biometric protected document storage.',
                      icon: Icons.shield_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DocumentSecureFolderScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const DocumentSectionTitle(
                title: 'Smart Folders',
              ),

              const SizedBox(height: 18),

              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: .95,
                physics:
                    const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _folder(
                    context,
                    title: 'Favorites',
                    count: documentsService
                        .favoriteDocuments.length,
                    icon: Icons.star_rounded,
                  ),
                  _folder(
                    context,
                    title: 'Recent',
                    count: documentsService
                        .recentDocuments.length,
                    icon: Icons.history_rounded,
                  ),
                  _folder(
                    context,
                    title: 'Secure',
                    count: _secureCount(),
                    icon: Icons.lock_outline_rounded,
                  ),
                  _folder(
                    context,
                    title: 'Hidden',
                    count: _hiddenCount(),
                    icon:
                        Icons.visibility_off_outlined,
                  ),
                  _folder(
                    context,
                    title: 'Trash',
                    count: documentsService
                        .deletedDocuments.length,
                    icon: Icons.delete_outline_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const DocumentSectionTitle(
                title: 'Document Categories',
              ),

              const SizedBox(height: 18),

              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: .95,
                physics:
                    const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _folder(
                    context,
                    title: 'School Documents',
                    count: _countByCategory(
                      'School Documents',
                    ),
                    icon: Icons.school_outlined,
                  ),
                  _folder(
                    context,
                    title: 'Bills',
                    count: _countByCategory('Bills'),
                    icon: Icons.receipt_long_outlined,
                  ),
                  _folder(
                    context,
                    title: 'Medical Records',
                    count: _countByCategory(
                      'Medical Records',
                    ),
                    icon: Icons.favorite_border,
                  ),
                  _folder(
                    context,
                    title: 'Business',
                    count: _countByCategory('Business'),
                    icon: Icons.work_outline,
                  ),
                  _folder(
                    context,
                    title: 'Receipts',
                    count: _countByCategory('Receipts'),
                    icon:
                        Icons.shopping_bag_outlined,
                  ),
                  _folder(
                    context,
                    title: 'Tax Documents',
                    count: _countByCategory(
                      'Tax Documents',
                    ),
                    icon:
                        Icons.account_balance_outlined,
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _folder(
    BuildContext context, {
    required String title,
    required int count,
    required IconData icon,
  }) {
    return DocumentFolderCard(
      title: title,
      count: count,
      icon: icon,
      onTap: () {
        if (title == 'Favorites') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const DocumentFavoritesScreen(),
            ),
          );
          return;
        }

        if (title == 'Recent') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const DocumentRecentScreen(),
            ),
          );
          return;
        }

        if (title == 'Secure') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const DocumentSecureFolderScreen(),
            ),
          );
          return;
        }

        if (title == 'Hidden') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const DocumentHiddenFolderScreen(),
            ),
          );
          return;
        }

        if (title == 'Trash') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const DocumentTrashScreen(),
            ),
          );
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                EmptyDocumentFolderScreen(
              folderTitle: title,
            ),
          ),
        );
      },
    );
  }
}
