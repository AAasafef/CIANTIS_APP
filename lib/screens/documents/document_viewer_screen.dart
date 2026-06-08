import 'dart:io';

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../models/document_model.dart';

import '../notes/notes_screen.dart';
import '../tasks/tasks_screen.dart';

class DocumentViewerScreen extends StatelessWidget {
  final DocumentModel document;

  const DocumentViewerScreen({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final extension =
        document.fileType.toLowerCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF4EFE8),
        elevation: 0,

        title: Text(
          document.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF2D241D),
            fontWeight: FontWeight.w400,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xFF2D241D),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 8,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TasksScreen(
                      spaceId: 'documents',
                      spaceName: 'Documents',
                      linkedItemId: document.id,
                    ),
                  ),
                );
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child: const Icon(
                  Icons.checklist_rounded,
                  size: 22,
                ),
              ),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.only(
              right: 12,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        NotesScreen(
                      spaceId:
                          'documents',
                      spaceName:
                          'Documents',
                      linkedItemId:
                          document.id,
                    ),
                  ),
                );
              },
              child: Container(
                width: 42,
                height: 42,
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child: const Icon(
                  Icons.edit_note_outlined,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                18,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    document.title,
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight
                              .w500,
                      color: Color(
                        0xFF2D241D,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    document.category,
                    style:
                        const TextStyle(
                      color: Color(
                        0xFF8B7D72,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    document.fileType
                        .toUpperCase(),
                    style:
                        const TextStyle(
                      color: Color(
                        0xFFB08D6D,
                      ),
                      letterSpacing:
                          1.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 18,
            ),

            Expanded(
              child: Container(
                width:
                    double.infinity,

                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    32,
                  ),
                ),

                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                    32,
                  ),
                  child:
                      _buildContent(
                    extension,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    String extension,
  ) {
    if (extension.contains(
          'pdf',
        )) {
      return SfPdfViewer.file(
        File(
          document.localPath,
        ),

        canShowPaginationDialog: true,
        canShowScrollHead: true,
        enableDoubleTapZooming: true,

        pageSpacing: 6,

        onDocumentLoadFailed:
            (details) {
          debugPrint(
            details.description,
          );
        },
      );
    }

    if (extension.contains(
          'jpg',
        ) ||
        extension.contains(
          'jpeg',
        ) ||
        extension.contains(
          'png',
        )) {
      return InteractiveViewer(
        minScale: 0.8,
        maxScale: 6,
        child: Image.file(
          File(
            document.localPath,
          ),
          fit: BoxFit.contain,
          errorBuilder:
              (
            context,
            error,
            stackTrace,
          ) {
            return _unsupported();
          },
        ),
      );
    }

    return _unsupported();
  }

  Widget _unsupported() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(
          30,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment
                  .center,
          children: [
            Container(
              height: 90,
              width: 90,

              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFFF4EFE8,
                ),
                borderRadius:
                    BorderRadius.circular(
                  26,
                ),
              ),

              child:
                  const Icon(
                Icons
                    .description_outlined,
                size: 42,
                color:
                    Color(
                  0xFF6E5846,
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            const Text(
              'Preview Not Available',
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.w400,
                color: Color(
                  0xFF2D241D,
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Text(
              'This file type is not supported yet.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color:
                    Colors.black
                        .withOpacity(
                  .55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}