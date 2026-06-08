import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

import 'glass_container.dart';
import 'luxury_small_button.dart';

class LuxuryBannerCard extends StatelessWidget {
  final String title;

  final String subtitle;

  final String buttonText;

  final VoidCallback onPressed;

  final IconData icon;

  const LuxuryBannerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius:
          CiantisTheme.radiusLarge,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: CiantisTheme.white,
            size: 42,
          ),

          const SizedBox(height: 18),

          Text(
            title,
            style: const TextStyle(
              color: CiantisTheme.white,
              fontSize: 24,
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

          LuxurySmallButton(
            text: buttonText,
            icon: Icons.arrow_forward_rounded,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
