import 'package:flutter/material.dart';

class LibraryBookCard extends StatelessWidget {
  final dynamic book;

  const LibraryBookCard({
    super.key,
    required this.book,
  });

  String _readValue(
    dynamic source,
    String key,
    String fallback,
  ) {
    try {
      if (source is Map && source.containsKey(key)) {
        return source[key]?.toString() ?? fallback;
      }

      final value = source.toJson()[key];

      return value?.toString() ?? fallback;
    } catch (_) {
      return fallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _readValue(
      book,
      'title',
      'Untitled Book',
    );

    final subtitle = _readValue(
      book,
      'subtitle',
      'Library item',
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE1D6CA),
          width: 0.7,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF3ECE4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.menu_book_outlined,
              size: 21,
              color: Color(0xFF8E6F55),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF241D18),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    height: 1.35,
                    color: Color(0xFF6F6258),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 22,
            color: Color(0xFF9A8D83),
          ),
        ],
      ),
    );
  }
}