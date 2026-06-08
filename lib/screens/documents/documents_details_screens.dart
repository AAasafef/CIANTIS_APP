import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/document_model.dart';

import '../../services/documents_service.dart';

import '../../widgets/document_action_button.dart';
import '../../widgets/document_delete_confirmation_sheet.dart';
import '../../widgets/document_rename_sheet.dart';

class DocumentDetailsScreen
    extends StatefulWidget {
  final DocumentModel document;

  const DocumentDetailsScreen({
    super.key,
    required this.document,
  });

  @override
  State<DocumentDetailsScreen>
      createState() =>
          _DocumentDetailsScreenState();
}

class _DocumentDetailsScreenState
    extends State<
        DocumentDetailsScreen> {
  final documentsService =
      DocumentsService.instance;

  late DocumentModel document;

  @override
  void initState() {
    super.initState();

    document = widget.document;
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        document.localPath
            .split('/')
            .last;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4EFE8),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                        true,
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color:
                            Color(0xFF2D241D),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Expanded(
                    child: Text(
                      'Document Details',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight:
                            FontWeight.w300,
                        letterSpacing: -.8,
                        color:
                            Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    28,
                  ),
                ),

                child: Column(
                  children: [
                    Container(
                      height: 84,
                      width: 84,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                          24,
                        ),
                        color: const Color(
                          0xFFF4EFE8,
                        ),
                      ),
                      child: Icon(
                        _icon(),
                        size: 38,
                        color: const Color(
                          0xFF6E5846,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Text(
                      document.title,
                      textAlign:
                          TextAlign.center,
                      style:
                          const TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.w500,
                        color: Color(
                          0xFF2D241D,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      document.category,
                      style: TextStyle(
                        color: Colors.black
                            .withOpacity(.58),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child:
                        DocumentActionButton(
                      icon:
                          Icons
                              .open_in_new,

                      label:
                          'Open',

                      onTap: () {
                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(
                          const SnackBar(
                            backgroundColor:
                                Color(
                              0xFF2D241D,
                            ),
                            content: Text(
                              'Document viewer placeholder.',
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child:
                        DocumentActionButton(
                      icon:
                          Icons.share_outlined,

                      label:
                          'Share',

                      onTap: () {
                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(
                          const SnackBar(
                            backgroundColor:
                                Color(
                              0xFF2D241D,
                            ),
                            content: Text(
                              'Share placeholder.',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child:
                        DocumentActionButton(
                      icon:
                          Icons
                              .edit_outlined,

                      label:
                          'Rename',

                      onTap:
                          _showRenameSheet,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child:
                        DocumentActionButton(
                      icon:
                          Icons
                              .delete_outline,

                      label:
                          'Delete',

                      onTap: () {
                        _showDeleteSheet();
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              _detailsTile(
                title:
                    'Connected Space',

                value:
                    document
                        .connectedSpace,
              ),

              _detailsTile(
                title: 'File Type',

                value: document
                    .fileType
                    .toUpperCase(),
              ),

              _detailsTile(
                title: 'Saved File',

                value: fileName,
              ),

              _detailsTile(
                title: 'Local Path',

                value:
                    document.localPath,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (File(
                      document.localPath,
                    ).existsSync()) {
                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(
                        const SnackBar(
                          backgroundColor:
                              Color(
                            0xFF2D241D,
                          ),
                          content: Text(
                            'Advanced document viewer coming later.',
                          ),
                        ),
                      );
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFF2D241D,
                    ),
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 18,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        24,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Open Full Document',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRenameSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return DocumentRenameSheet(
          currentTitle:
              document.title,
          onRename: (
            newTitle,
          ) {
            documentsService
                .renameDocument(
              id: document.id,
              newTitle:
                  newTitle,
            );

            setState(() {
              document =
                  document.copyWith(
                title:
                    newTitle,
              );
            });

            ScaffoldMessenger.of(
                    context)
                .showSnackBar(
              const SnackBar(
                backgroundColor:
                    Color(
                  0xFF2D241D,
                ),
                content: Text(
                  'Document renamed.',
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          Colors.transparent,
      builder: (_) {
        return DocumentDeleteConfirmationSheet(
          onDelete: () {
            documentsService
                .deleteDocument(
              document.id,
            );

            Navigator.pop(
              context,
              true,
            );

            ScaffoldMessenger.of(
                    context)
                .showSnackBar(
              const SnackBar(
                backgroundColor:
                    Color(
                  0xFF2D241D,
                ),
                content: Text(
                  'Document deleted.',
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _detailsTile({
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
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
          24,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black
                  .withOpacity(.55),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color:
                  Color(0xFF2D241D),
            ),
          ),
        ],
      ),
    );
  }

  IconData _icon() {
    switch (
        document.fileType
            .toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;

      case 'doc':
        return Icons.description;

      case 'image':
        return Icons.image_outlined;

      default:
        return Icons.folder_outlined;
    }
  }
}