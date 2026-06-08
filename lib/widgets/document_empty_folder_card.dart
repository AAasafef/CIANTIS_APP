import 'package:flutter/material.dart';

class DocumentEmptyFolderCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const DocumentEmptyFolderCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 84,
            width: 84,
            decoration: BoxDecoration(
              color: const Color(0xFFF4EFE8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.folder_open_outlined,
              size: 38,
              color: Color(0xFF6E5846),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2D241D),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black.withOpacity(.55),
            ),
          ),
        ],
      ),
    );
  }
}