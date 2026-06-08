import 'package:flutter/material.dart';

import '../../services/activity_log_service.dart';
import '../../services/document_file_service.dart';
import '../../services/documents_service.dart';

import '../../widgets/ciantis_side_drawer.dart';
import '../../widgets/document_card.dart';
import '../../widgets/document_empty_state.dart';
import '../../widgets/document_search_bar.dart';
import '../../widgets/document_security_banner.dart';
import '../../widgets/document_stats_card.dart';

import 'deleted_documents_screen.dart';
import 'document_save_confirmation_screen.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({
    super.key,
  });

  @override
  State<DocumentsScreen> createState() =>
      _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  final DocumentsService documentsService =
      DocumentsService.instance;

  final DocumentFileService fileService =
      DocumentFileService.instance;

  String selectedCategory = 'All';
  String selectedSubCategory = 'All';
  String selectedFileType = 'All Types';
  String searchQuery = '';
  String selectedSort = 'Newest First';

  bool isLoading = true;
  bool isPickingFile = false;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    await documentsService.initialize();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final allDocuments =
        documentsService.documents;

    final documents =
        allDocuments.where((doc) {
      final categoryMatch =
          _categoryMatches(doc.category);

      final subCategoryMatch =
          selectedSubCategory == 'All'
              ? true
              : doc.category
                  .toLowerCase()
                  .contains(
                    selectedSubCategory
                        .toLowerCase(),
                  );

      final searchMatch =
          doc.title.toLowerCase().contains(
                searchQuery.toLowerCase(),
              );

      final fileTypeMatch =
          selectedFileType == 'All Types'
              ? true
              : doc.fileType.toUpperCase() ==
                  selectedFileType;

      return categoryMatch &&
          subCategoryMatch &&
          searchMatch &&
          fileTypeMatch;
    }).toList();

    switch (selectedSort) {
      case 'Newest First':
        documents.sort(
          (a, b) => b.uploadedAt.compareTo(
            a.uploadedAt,
          ),
        );
        break;
      case 'Oldest First':
        documents.sort(
          (a, b) => a.uploadedAt.compareTo(
            b.uploadedAt,
          ),
        );
        break;
      case 'Title A-Z':
        documents.sort(
          (a, b) => a.title.compareTo(
            b.title,
          ),
        );
        break;
      case 'Category':
        documents.sort(
          (a, b) => a.category.compareTo(
            b.category,
          ),
        );
        break;
      case 'File Type':
        documents.sort(
          (a, b) => a.fileType.compareTo(
            b.fileType,
          ),
        );
        break;
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4EFE8),
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth:
          MediaQuery.of(context).size.width,
      drawer: const CiantisSideDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2D241D),
        elevation: 0,
        onPressed:
            isPickingFile ? null : _showUploadSheet,
        child: isPickingFile
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(
                Icons.add,
                color: Colors.white,
              ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 10) {
            _scaffoldKey.currentState
                ?.openDrawer();
          }
        },
        child: SafeArea(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF2D241D),
                  ),
                )
              : CustomScrollView(
                  physics:
                      const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding:
                          const EdgeInsets.fromLTRB(
                        20,
                        22,
                        20,
                        0,
                      ),
                      sliver: SliverList(
                        delegate:
                            SliverChildListDelegate(
                          [
                            const Text(
                              'Documents',
                              maxLines: 1,
                              overflow:
                                  TextOverflow.visible,
                              style: TextStyle(
                                fontSize: 44,
                                fontWeight:
                                    FontWeight.w300,
                                letterSpacing: -1.4,
                                color:
                                    Color(0xFF2D241D),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              'Securely scan, upload, organize, and access your important files.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black
                                    .withOpacity(
                                  .58,
                                ),
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DocumentSearchBar(
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            const DocumentSecurityBanner(),
                            const SizedBox(
                              height: 22,
                            ),
                            DocumentStatsCard(
                              totalDocuments:
                                  documents.length,
                              selectedCategory:
                                  selectedCategory,
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            _activeFolderHeader(),
                            const SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (documents.isEmpty)
                      const SliverPadding(
                        padding:
                            EdgeInsets.fromLTRB(
                          20,
                          20,
                          20,
                          140,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: DocumentEmptyState(
                            title:
                                'No Documents Found',
                            subtitle:
                                'Swipe from the left to open your universal menu, or tap + to scan or upload.',
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(
                          20,
                          0,
                          20,
                          140,
                        ),
                        sliver: SliverList(
                          delegate:
                              SliverChildBuilderDelegate(
                            (context, index) {
                              return DocumentCard(
                                document:
                                    documents[index],
                                onUpdated: () {
                                  setState(() {});
                                },
                              );
                            },
                            childCount:
                                documents.length,
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _activeFolderHeader() {
    final title =
        selectedSubCategory == 'All'
            ? selectedCategory
            : '$selectedCategory / $selectedSubCategory';

    return Row(
      children: [
        Expanded(
          child: Text(
            title == 'All'
                ? 'All Documents'
                : title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2D241D),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const DeletedDocumentsScreen(),
              ),
            );

            if (mounted) {
              setState(() {});
            }
          },
          child: Text(
            'Deleted',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(.48),
            ),
          ),
        ),
      ],
    );
  }

  bool _categoryMatches(String docCategory) {
    if (selectedCategory == 'All') {
      return true;
    }

    if (selectedCategory == 'All Documents') {
      return true;
    }

    final doc = docCategory.toLowerCase();
    final selected =
        selectedCategory.toLowerCase();

    if (doc == selected) return true;
    if (doc.contains(selected)) return true;

    if (selectedCategory == 'School' &&
        doc.contains('school')) {
      return true;
    }

    if (selectedCategory == 'Business' &&
        doc.contains('business')) {
      return true;
    }

    if (selectedCategory == 'Medical' &&
        doc.contains('medical')) {
      return true;
    }

    if (selectedCategory == 'Family' &&
        doc.contains('family')) {
      return true;
    }

    if (selectedCategory == 'Receipts' &&
        doc.contains('receipt')) {
      return true;
    }

    if (selectedCategory == 'Taxes' &&
        doc.contains('tax')) {
      return true;
    }

    if (selectedCategory == 'Bills' &&
        doc.contains('bill')) {
      return true;
    }

    if (selectedCategory == 'Legal' &&
        doc.contains('legal')) {
      return true;
    }

    if (selectedCategory == 'IDs' &&
        doc.contains('id')) {
      return true;
    }

    if (selectedCategory == 'Insurance' &&
        doc.contains('insurance')) {
      return true;
    }

    return false;
  }

  void _showUploadSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFFF8F3EC),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(34),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload Document',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF2D241D),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Ciantis will intelligently organize and connect your documents later.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(.58),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 28),
                _uploadOption(
                  icon: Icons.camera_alt_outlined,
                  title: 'Scan Document',
                  subtitle: 'Use camera scanner',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _scanDocument();
                  },
                ),
                const SizedBox(height: 16),
                _uploadOption(
                  icon: Icons.upload_file_outlined,
                  title: 'Upload File',
                  subtitle:
                      'PDF, DOC, image, and more',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _uploadFile();
                  },
                ),
                const SizedBox(height: 16),
                _uploadOption(
                  icon: Icons.auto_awesome_outlined,
                  title: 'AI Organize',
                  subtitle:
                      'Automatically categorize files',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showAiComingSoon();
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _uploadFile() async {
    if (isPickingFile) return;

    setState(() {
      isPickingFile = true;
    });

    try {
      final PickedDocumentFile? file =
          await fileService.pickFile();

      if (!mounted) return;

      setState(() {
        isPickingFile = false;
      });

      if (file == null) return;

      await ActivityLogService.instance.addActivity(
        title: 'File Imported',
        description: file.name,
        spaceId: 'documents',
        spaceName: 'Documents',
        actionType: 'uploaded',
      );

      await _openConfirmationScreen(file);
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isPickingFile = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor:
              const Color(0xFF2D241D),
          content: Text(
            'Upload failed: $error',
          ),
        ),
      );
    }
  }

  Future<void> _scanDocument() async {
    if (isPickingFile) return;

    setState(() {
      isPickingFile = true;
    });

    try {
      final PickedDocumentFile? file =
          await fileService.scanWithCamera();

      if (!mounted) return;

      setState(() {
        isPickingFile = false;
      });

      if (file == null) return;

      await ActivityLogService.instance.addActivity(
        title: 'Document Scanned',
        description: file.name,
        spaceId: 'documents',
        spaceName: 'Documents',
        actionType: 'uploaded',
      );

      await _openConfirmationScreen(file);
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isPickingFile = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor:
              const Color(0xFF2D241D),
          content: Text(
            'Scan failed: $error',
          ),
        ),
      );
    }
  }

  Future<void> _openConfirmationScreen(
    PickedDocumentFile file,
  ) async {
    final fileName = file.name;
    final fileType =
        fileService.detectFileType(file.name);
    final suggestedCategory =
        fileService.suggestCategory(fileName);

    final bool? saved =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            DocumentSaveConfirmationScreen(
          file: file,
          suggestedCategory: suggestedCategory,
          fileType: fileType,
          onConfirm: (category) async {
            await documentsService.addDocument(
              title: fileName,
              category: category,
              fileType: fileType,
              localPath: file.savedPath,
              connectedSpace: 'Documents',
            );

            await ActivityLogService.instance
                .addActivity(
              title: 'Document Added',
              description:
                  '$fileName saved to $category',
              spaceId: 'documents',
              spaceName: 'Documents',
              actionType: 'created',
            );
          },
        ),
      ),
    );

    if (!mounted) return;

    if (saved == true) {
      await documentsService.initialize();

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF2D241D),
          content: Text(
            'Document saved',
          ),
        ),
      );
    }
  }

  void _showAiComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF2D241D),
        content: Text(
          'AI organization placeholder ready. Real AI comes later.',
        ),
      ),
    );
  }

  Widget _uploadOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(18),
                  color: const Color(0xFFF4EFE8),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF6E5846),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w400,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black
                            .withOpacity(.55),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Color(0xFFB08D6D),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
