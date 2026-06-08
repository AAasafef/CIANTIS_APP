import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';
import 'glass_container.dart';

class LuxuryToggleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const LuxuryToggleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: GlassContainer(
        borderRadius:
            CiantisTheme.radiusLarge,
        child: Row(
          children: [

            Icon(
              icon,
              color: CiantisTheme.white,
              size: 28,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      color:
                          CiantisTheme.white,
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w300,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: CiantisTheme
                          .whiteSoft,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            Switch(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
