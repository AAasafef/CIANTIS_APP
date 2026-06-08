import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class LuxurySmallButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const LuxurySmallButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.10),
          borderRadius: BorderRadius.circular(
            16,
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
                color: CiantisTheme.white,
                size: 16,
              ),

            if (icon != null)
              const SizedBox(width: 8),

            Text(
              text,
              style: const TextStyle(
                color: CiantisTheme.white,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
