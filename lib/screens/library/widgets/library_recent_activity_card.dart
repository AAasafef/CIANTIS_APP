import 'package:flutter/material.dart';

class LibraryRecentActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const LibraryRecentActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  static const Color darkText = Color(0xFF2D241D);
  static const Color softText = Color(0xFF7A6A5D);
  static const Color cardColor = Color(0xFFFFFBF6);
  static const Color borderColor = Color(0xFFE4D8CB);
  static const Color accent = Color(0xFFB08D6D);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE2D6),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: accent,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: darkText,
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: softText,
                    fontSize: 12,
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