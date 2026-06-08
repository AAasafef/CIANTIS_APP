import 'package:flutter/material.dart';

import '../screens/documents/document_activity_screen.dart';

class DocumentStatsCard
    extends StatelessWidget {
  final int totalDocuments;

  final String selectedCategory;

  const DocumentStatsCard({
    super.key,
    required this.totalDocuments,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DocumentActivityScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          24,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFB08D6D),
              Color(0xFFD8C2AE),
            ],
          ),
          borderRadius: BorderRadius.circular(
            32,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    '$totalDocuments',
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight:
                          FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  const Text(
                    'Documents Stored',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(
                    height: 14,
                  ),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Colors.white.withOpacity(
                        .18,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                    child: Text(
                      selectedCategory,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 82,
              width: 82,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  .14,
                ),
                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),
              child: const Icon(
                Icons.folder_copy_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}