import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: const TextStyle(
            color: CiantisTheme.white,
            fontSize: 38,
            fontWeight: FontWeight.w300,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          subtitle,
          style: const TextStyle(
            color: CiantisTheme.whiteSoft,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
