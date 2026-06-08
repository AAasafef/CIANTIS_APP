import 'package:flutter/material.dart';

import '../../services/documents_service.dart';
import '../../widgets/document_empty_folder_card.dart';

class DocumentTrashScreen extends StatefulWidget {
  const DocumentTrashScreen({
    super.key,
  });

  @override
  State<DocumentTrashScreen> createState() =>
      _DocumentTrashScreenState();
}

class _DocumentTrashScreenState
    extends State<DocumentTrashScreen> {
  final DocumentsService documentsService =
      DocumentsService.instance;

  bool changed = false;

  Future<void> _restoreDocument(
    dynamic document,
  ) async {
    await documentsService.restoreDocument(
      document,
    );

    changed = true;

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _deleteForever(
    dynamic document,
  ) async {
    await documentsService
        .permanentlyDeleteDocument(
      document,
    );

    changed = true;

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _emptyTrash() async {
    await documentsService.emptyTrash();

    changed = true;

    if (!mounted) return;

    setState(() {});
  }

  void _goBack() {
    Navigator.pop(
      context,
      changed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deletedDocuments =
        documentsService.deletedDocuments;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4EFE8),
        elevation: 0,
        leading: IconButton(
          onPressed: _goBack,
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF2D241D),
          ),
        ),
        title: const Text(
          'Trash',
          style: TextStyle(
            color: Color(0xFF2D241D),
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          if (deletedDocuments.isNotEmpty)
            TextButton(
              onPressed: _emptyTrash,
              child: const Text(
                'Empty',
                style: TextStyle(
                  color: Color(0xFFB08D6D),
                ),
              ),
            ),
        ],
      ),
      body: deletedDocuments.isEmpty
          ? const Center(
              child: DocumentEmptyFolderCard(
                title: 'Trash is Empty',
                subtitle:
                    'Deleted documents will appear here.',
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: deletedDocuments.length,
              itemBuilder: (context, index) {
                final document =
                    deletedDocuments[index];

                return Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),
                  padding:
                      const EdgeInsets.all(
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                      28,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.title,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                        style:
                            const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w500,
                          color:
                              Color(0xFF2D241D),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${document.category} • ${document.fileType}',
                        style: const TextStyle(
                          fontSize: 12,
                          color:
                              Color(0xFF8B7D72),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child:
                                OutlinedButton(
                              onPressed: () {
                                _restoreDocument(
                                  document,
                                );
                              },
                              style: OutlinedButton
                                  .styleFrom(
                                foregroundColor:
                                    const Color(
                                  0xFF2D241D,
                                ),
                                side:
                                    const BorderSide(
                                  color: Color(
                                    0xFFD8C2AE,
                                  ),
                                ),
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  vertical: 14,
                                ),
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    18,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Restore',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child:
                                ElevatedButton(
                              onPressed: () {
                                _deleteForever(
                                  document,
                                );
                              },
                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    const Color(
                                  0xFF2D241D,
                                ),
                                foregroundColor:
                                    Colors.white,
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  vertical: 14,
                                ),
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    18,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Delete',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
