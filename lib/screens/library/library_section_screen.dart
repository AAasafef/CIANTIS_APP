import 'package:flutter/material.dart';

import 'data/library_demo_books.dart';
import 'widgets/library_book_card.dart';

class LibrarySectionScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const LibrarySectionScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  static const Color background = Color(0xFFF4EFE8);
  static const Color darkText = Color(0xFF2D241D);
  static const Color softText = Color(0xFF7A6A5D);
  static const Color cardColor = Color(0xFFFFFBF6);
  static const Color borderColor = Color(0xFFE4D8CB);
  static const Color accent = Color(0xFFB08D6D);

  bool get isBooksSection => title.toLowerCase() == 'books';

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
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                ),
                child: Icon(
                  icon,
                  color: accent,
                  size: 28,
                ),
              ),
              const SizedBox(height: 18),
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
              Text(
                subtitle,
                style: const TextStyle(
                  color: softText,
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 24),
              _searchBox(),
              const SizedBox(height: 24),
              if (isBooksSection) ...[
                _booksHeader(),
                const SizedBox(height: 14),
                ...demoBooks.map(
                  (book) => LibraryBookCard(book: book),
                ),
                const SizedBox(height: 10),
              ] else ...[
                _emptyCard(),
                const SizedBox(height: 22),
              ],
              _actionCard(
                title: 'Add New Item',
                subtitle: 'Create or import something into this section.',
                icon: Icons.add_rounded,
              ),
              const SizedBox(height: 12),
              _actionCard(
                title: 'Organize',
                subtitle: 'Sort by title, date added, progress, or collection.',
                icon: Icons.tune_rounded,
              ),
              const SizedBox(height: 12),
              _actionCard(
                title: 'Section Settings',
                subtitle: 'Customize how this library section behaves.',
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

  Widget _searchBox() {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: softText,
            size: 21,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search this section...',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: softText,
                fontSize: 13.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _booksHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE2D6),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reading Shelf',
            style: TextStyle(
              color: darkText,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Track your books, favorite titles, and reading progress here.',
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
          Text(
            'Nothing saved here yet',
            style: TextStyle(
              color: darkText,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'When you add items to this section, they will appear here in a clean organized list.',
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