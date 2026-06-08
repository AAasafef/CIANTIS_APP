import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class LuxuryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const LuxuryButton({
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
        height: 58,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.12),
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(
              .10,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [

            if (icon != null)
              Icon(
                icon,
                color: CiantisTheme.white,
              ),

            if (icon != null)
              const SizedBox(width: 10),

            Text(
              text,
              style: const TextStyle(
                color: CiantisTheme.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
