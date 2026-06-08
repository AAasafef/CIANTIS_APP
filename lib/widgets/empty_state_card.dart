import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class EmptyStateCard extends StatelessWidget {
  final IconData icon;

  final String title;

  final String subtitle;

  const EmptyStateCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(
        28,
      ),

      decoration: BoxDecoration(
        color:
            Colors.white.withOpacity(
          .06,
        ),

        borderRadius:
            BorderRadius.circular(
          28,
        ),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            size: 52,
            color:
                CiantisTheme.whiteSoft,
          ),

          const SizedBox(height: 18),

          Text(
            title,
            style: const TextStyle(
              color: CiantisTheme.white,
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color:
                  CiantisTheme.whiteSoft,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
