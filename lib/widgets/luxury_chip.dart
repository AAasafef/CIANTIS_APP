import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class LuxuryChip extends StatelessWidget {
  final String text;
  final IconData? icon;

  const LuxuryChip({
    super.key,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(
          18,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(
            .08,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          if (icon != null)
            Icon(
              icon,
              color: CiantisTheme.whiteSoft,
              size: 16,
            ),

          if (icon != null)
            const SizedBox(width: 8),

          Text(
            text,
            style: const TextStyle(
              color: CiantisTheme.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
