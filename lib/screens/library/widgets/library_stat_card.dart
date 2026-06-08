import 'package:flutter/material.dart';

class LibraryStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const LibraryStatCard({
    super.key,
    required this.title,
    required this.value,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: accent,
            size: 24,
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              color: darkText,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              color: softText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}