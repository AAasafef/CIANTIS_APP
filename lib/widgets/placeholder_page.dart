import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';
import 'glass_container.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const PlaceholderPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: GlassContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: CiantisTheme.white,
                size: 52,
              ),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CiantisTheme.white,
                  fontSize: CiantisTheme.titleSize,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CiantisTheme.whiteSoft,
                  fontSize: CiantisTheme.bodySize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
