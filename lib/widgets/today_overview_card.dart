import 'package:flutter/material.dart';

import 'glass_container.dart';

class TodayOverviewCard
    extends StatelessWidget {

  const TodayOverviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 34,

      padding:
          const EdgeInsets.all(
        24,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            'Today',
            style: TextStyle(
              color:
                  Colors.white
                      .withOpacity(
                .65,
              ),

              fontSize: 14,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Your Life OS is synced and ready.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight:
                  FontWeight.w300,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            'Your routines, wellness, goals, and family systems are organized beautifully in one place.',
            style: TextStyle(
              color:
                  Colors.white
                      .withOpacity(
                .70,
              ),

              fontSize: 14,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [

              _heroButton(
                icon:
                    Icons.auto_awesome,

                text:
                    'Focus Mode',
              ),

              const SizedBox(width: 14),

              _heroButton(
                icon:
                    Icons.favorite_border,

                text:
                    'Wellness',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroButton({
    required IconData icon,
    required String text,
  }) {
    return Expanded(
      child: Container(
        height: 54,

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

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),

            const SizedBox(width: 10),

            Text(
              text,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
