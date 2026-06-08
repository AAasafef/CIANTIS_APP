import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class AppIconTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const AppIconTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              color: CiantisTheme.white,
              borderRadius: BorderRadius.circular(
                CiantisTheme.radiusMedium,
              ),
            ),
            child: Icon(
              icon,
              color: CiantisTheme.warmBrown,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: CiantisTheme.smallSize,
              color: CiantisTheme.textBrown,
            ),
          ),
        ],
      ),
    );
  }
}
