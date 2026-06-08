import 'package:flutter/material.dart';

class DocumentAiBanner extends StatelessWidget {
  const DocumentAiBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        22,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFB08D6D),
            Color(0xFFD8C2AE),
          ],
        ),
        borderRadius:
            BorderRadius.circular(
          30,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white
                  .withOpacity(
                .18,
              ),
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
            ),
          ),

          const SizedBox(
            width: 18,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                const Text(
                  'Ciantis AI Ready',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  'AI summaries, document insights, smart categorization, duplicate detection, folder suggestions, and document search intelligence.',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(
                      .90,
                    ),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration:
                      BoxDecoration(
                    color: Colors.white
                        .withOpacity(
                      .15,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      999,
                    ),
                  ),
                  child: const Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}