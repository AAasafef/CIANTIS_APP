import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class LuxuryDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const LuxuryDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:
          Colors.transparent,

      child: Container(
        padding: const EdgeInsets.all(
          24,
        ),

        decoration: BoxDecoration(
          color: const Color(
            0xFF1E1E1E,
          ),

          borderRadius:
              BorderRadius.circular(
            28,
          ),

          border: Border.all(
            color:
                Colors.white.withOpacity(
              .08,
            ),
          ),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              title,
              style: const TextStyle(
                color: CiantisTheme.white,
                fontSize: 26,
                fontWeight: FontWeight.w300,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              subtitle,
              style: const TextStyle(
                color:
                    CiantisTheme.whiteSoft,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            child,
          ],
        ),
      ),
    );
  }
}
