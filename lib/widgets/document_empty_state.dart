import 'package:flutter/material.dart';

class DocumentEmptyState
    extends StatelessWidget {
  final String title;

  final String subtitle;

  const DocumentEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Container(
            height: 92,
            width: 92,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.folder_copy_outlined,
              size: 42,
              color: Color(0xFF6E5846),
            ),
          ),

          const SizedBox(height: 28),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w300,
              letterSpacing: -.8,
              color: Color(0xFF2D241D),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color:
                  Colors.black.withOpacity(.58),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}