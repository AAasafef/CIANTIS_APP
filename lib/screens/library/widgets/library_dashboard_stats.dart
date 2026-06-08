import 'package:flutter/material.dart';

class LibraryDashboardStats extends StatelessWidget {
  const LibraryDashboardStats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _statCard(
          title: 'Books',
          value: '0',
          icon: Icons.menu_book_outlined,
        ),
        const SizedBox(width: 10),
        _statCard(
          title: 'Notes',
          value: '0',
          icon: Icons.edit_note_outlined,
        ),
        const SizedBox(width: 10),
        _statCard(
          title: 'Saved',
          value: '0',
          icon: Icons.bookmark_border_rounded,
        ),
      ],
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8F4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFE1D6CA),
            width: 0.7,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF8E6F55),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Color(0xFF241D18),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color(0xFF6F6258),
              ),
            ),
          ],
        ),
      ),
    );
  }
}