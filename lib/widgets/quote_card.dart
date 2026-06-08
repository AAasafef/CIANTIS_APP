import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';
import 'glass_container.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Icon(
            Icons.format_quote_rounded,
            color: CiantisTheme.whiteSoft,
            size: 34,
          ),

          const SizedBox(height: 14),

          Text(
            quote,
            style: const TextStyle(
              color: CiantisTheme.white,
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            '- $author',
            style: const TextStyle(
              color: CiantisTheme.whiteSoft,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
