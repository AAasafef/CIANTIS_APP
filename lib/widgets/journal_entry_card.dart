import 'package:flutter/material.dart';

import '../models/journal_entry_model.dart';

class JournalEntryCard extends StatelessWidget {
  final JournalEntryModel entry;

  const JournalEntryCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4EC),
        borderRadius: BorderRadius.circular(
          18,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              .05,
            ),
            blurRadius: 10,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          18,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter:
                    _NotebookPaperPainter(),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.all(
                20,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '📝',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Expanded(
                        child: Text(
                          entry.title,
                          style:
                              const TextStyle(
                            color: Color(
                              0xFF3A342D,
                            ),
                            fontSize: 22,
                            fontWeight:
                                FontWeight
                                    .w300,
                            fontFamily:
                                'PatrickHand',
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Text(
                    _truncateContent(
                      entry.content,
                    ),
                    style:
                        const TextStyle(
                      color: Color(
                        0xFF5D564F,
                      ),
                      fontSize: 16,
                      height: 1.8,
                      fontFamily:
                          'PatrickHand',
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets
                            .all(
                      12,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white
                              .withOpacity(
                        .45,
                      ),
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        const Text(
                          'Summary',
                          style:
                              TextStyle(
                            fontSize:
                                12,
                            fontWeight:
                                FontWeight
                                    .w600,
                            color: Color(
                              0xFF8C847B,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          _buildSummary(
                            entry.content,
                          ),
                          style:
                              const TextStyle(
                            color:
                                Color(
                              0xFF5D564F,
                            ),
                            fontSize:
                                13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children:
                        _buildKeywords(
                      entry.content,
                    )
                            .map(
                              (
                                keyword,
                              ) =>
                                  Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal:
                                      10,
                                  vertical:
                                      5,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color: const Color(
                                    0xFFECE5DA,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: Text(
                                  keyword,
                                  style:
                                      const TextStyle(
                                    fontSize:
                                        11,
                                    color:
                                        Color(
                                      0xFF6A625A,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  Text(
                    _formatDate(
                      entry.createdAt,
                    ),
                    style:
                        const TextStyle(
                      color: Color(
                        0xFF9D948A,
                      ),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _truncateContent(
    String content,
  ) {
    if (content.length <= 180) {
      return content;
    }

    return '${content.substring(0, 180)}...';
  }

  String _buildSummary(
    String content,
  ) {
    if (content.isEmpty) {
      return 'No summary available.';
    }

    if (content.length < 90) {
      return content;
    }

    return '${content.substring(0, 90)}...';
  }

  List<String> _buildKeywords(
    String content,
  ) {
    final words =
        content
            .split(' ')
            .where(
              (word) =>
                  word.length > 5,
            )
            .take(5)
            .toList();

    if (words.isEmpty) {
      return [
        'Journal',
      ];
    }

    return words;
  }

  String _formatDate(
    DateTime date,
  ) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

class _NotebookPaperPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final linePaint =
        Paint()
          ..color =
              const Color(
                0xFFBFD3E6,
              ).withOpacity(
                .18,
              )
          ..strokeWidth = 1;

    for (
      double y = 50;
      y < size.height;
      y += 28
    ) {
      canvas.drawLine(
        Offset(0, y),
        Offset(
          size.width,
          y,
        ),
        linePaint,
      );
    }

    final marginPaint =
        Paint()
          ..color =
              const Color(
                0xFFE3B0B0,
              ).withOpacity(
                .25,
              )
          ..strokeWidth = 1.2;

    canvas.drawLine(
      const Offset(
        40,
        0,
      ),
      Offset(
        40,
        size.height,
      ),
      marginPaint,
    );
  }

  @override
  bool shouldRepaint(
    CustomPainter oldDelegate,
  ) {
    return false;
  }
}