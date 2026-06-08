import 'package:flutter/material.dart';

class LibraryCollectionScreen extends StatelessWidget {
  final String title;

  const LibraryCollectionScreen({
    super.key,
    required this.title,
  });

  static const Color background = Color(0xFFF4EFE8);
  static const Color darkText = Color(0xFF2D241D);
  static const Color softText = Color(0xFF7A6A5D);
  static const Color cardColor = Color(0xFFFFFBF6);
  static const Color borderColor = Color(0xFFE4D8CB);
  static const Color accent = Color(0xFFB08D6D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBar(context),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  color: darkText,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'A curated shelf inside your personal library.',
                style: TextStyle(
                  color: softText,
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 24),
              _emptyCard(),
              const SizedBox(height: 18),
              _actionCard(
                title: 'Add Item',
                subtitle: 'Add a book, audiobook, document, note, or quote.',
                icon: Icons.add_rounded,
              ),
              const SizedBox(height: 12),
              _actionCard(
                title: 'Sort Collection',
                subtitle: 'Organize this shelf by title, date, type, or progress.',
                icon: Icons.sort_rounded,
              ),
              const SizedBox(height: 12),
              _actionCard(
                title: 'Collection Settings',
                subtitle: 'Rename, archive, or customize this collection.',
                icon: Icons.settings_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: borderColor),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: darkText,
              size: 20,
            ),
          ),
        ),
        const Spacer(),
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: darkText,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _emptyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.folder_open_outlined,
            color: accent,
            size: 30,
          ),
          SizedBox(height: 16),
          Text(
            'This collection is empty',
            style: TextStyle(
              color: darkText,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Items you choose for this shelf will appear here. Nothing is added automatically.',
            style: TextStyle(
              color: softText,
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: accent,
            size: 22,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: darkText,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: softText,
                    fontSize: 12.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: softText,
            size: 21,
          ),
        ],
      ),
    );
  }
}