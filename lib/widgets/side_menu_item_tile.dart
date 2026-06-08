import 'package:flutter/material.dart';

import '../theme/ciantis_theme.dart';

import 'notification_badge.dart';

class SideMenuItemTile extends StatelessWidget {
  final IconData icon;

  final String title;

  final VoidCallback onTap;

  final String? badgeCount;

  const SideMenuItemTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),

          decoration: BoxDecoration(
            color:
                Colors.white.withOpacity(
              .06,
            ),

            borderRadius:
                BorderRadius.circular(
              18,
            ),
          ),

          child: Row(
            children: [

              Icon(
                icon,
                color:
                    CiantisTheme.white,
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color:
                        CiantisTheme.white,
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w300,
                  ),
                ),
              ),

              if (badgeCount != null)
                NotificationBadge(
                  count: badgeCount!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
