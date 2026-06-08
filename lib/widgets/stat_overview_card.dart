import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

class StatOverviewCard extends StatelessWidget {
  final String value;

  final String label;

  final IconData icon;

  const StatOverviewCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(
          18,
        ),

        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(
            .08,
          ),

          borderRadius:
              BorderRadius.circular(
            22,
          ),
        ),

        child: Column(
          children: [

            Icon(
              icon,
              color:
                  CiantisTheme.white,
            ),

            const SizedBox(height: 12),

            Text(
              value,
              style: const TextStyle(
                color: CiantisTheme.white,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color:
                    CiantisTheme.whiteSoft,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
