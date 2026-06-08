import 'package:flutter/material.dart';

import '../../services/documents_service.dart';

class DocumentActivityScreen extends StatelessWidget {
  const DocumentActivityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final recentDocuments =
        DocumentsService.instance.recentDocuments;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF4EFE8,
      ),
      appBar: AppBar(
        backgroundColor: const Color(
          0xFFF4EFE8,
        ),
        elevation: 0,
        title: const Text(
          'Recent Documents',
          style: TextStyle(
            color: Color(
              0xFF2D241D,
            ),
            fontWeight:
                FontWeight.w400,
          ),
        ),
        iconTheme:
            const IconThemeData(
          color: Color(
            0xFF2D241D,
          ),
        ),
      ),
      body: recentDocuments.isEmpty
          ? const Center(
              child: Text(
                'No recent documents yet',
                style: TextStyle(
                  color: Color(
                    0xFF8B7D72,
                  ),
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.all(
                20,
              ),
              itemCount:
                  recentDocuments.length,
              itemBuilder:
                  (context, index) {
                final document =
                    recentDocuments[
                        index];

                return Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),
                  padding:
                      const EdgeInsets.all(
                    20,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                      28,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFFF4EFE8,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),
                        child: Icon(
                          document.fileType
                                  .toLowerCase()
                                  .contains(
                                    'pdf',
                                  )
                              ? Icons
                                  .picture_as_pdf_outlined
                              : Icons
                                  .description_outlined,
                          color:
                              const Color(
                            0xFF6E5846,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              document.title,
                              maxLines: 1,
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                              style:
                                  const TextStyle(
                                fontSize:
                                    16,
                                fontWeight:
                                    FontWeight
                                        .w500,
                                color:
                                    Color(
                                  0xFF2D241D,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              document
                                  .category,
                              style:
                                  TextStyle(
                                fontSize:
                                    13,
                                color: Colors
                                    .black
                                    .withOpacity(
                                  .55,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              document
                                  .fileType,
                              style:
                                  const TextStyle(
                                fontSize:
                                    12,
                                color:
                                    Color(
                                  0xFFB08D6D,
                                ),
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (document
                          .isFavorite)
                        const Icon(
                          Icons
                              .star_rounded,
                          color: Color(
                            0xFFB08D6D,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}