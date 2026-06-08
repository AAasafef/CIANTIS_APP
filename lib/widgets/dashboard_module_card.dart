import 'package:flutter/material.dart';

import 'glass_container.dart';

class DashboardModuleCard
    extends StatelessWidget {

  final String title;

  final String subtitle;

  final IconData icon;

  final VoidCallback onTap;

  const DashboardModuleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: GlassContainer(
        borderRadius: 30,

        padding:
            const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Container(
              height: 56,
              width: 56,

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),

                color:
                    Colors.white
                        .withOpacity(
                  .08,
                ),
              ),

              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),

            const Spacer(),

            Text(
              title,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight:
                    FontWeight.w300,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              subtitle,

              style: TextStyle(
                color:
                    Colors.white
                        .withOpacity(
                  .58,
                ),

                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
