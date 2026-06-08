import 'package:flutter/material.dart';

import 'glass_container.dart';

class HabitProgressCard
    extends StatelessWidget {

  final String title;

  final String progress;

  final double percent;

  final IconData icon;

  const HabitProgressCard({
    super.key,
    required this.title,
    required this.progress,
    required this.percent,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 28,

      padding:
          const EdgeInsets.all(
        20,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                height: 48,
                width: 48,

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    18,
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
                progress,

                style: TextStyle(
                  color:
                      Colors.white
                          .withOpacity(
                    .72,
                  ),

                  fontSize: 13,
                ),
              ),
            ],
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

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              20,
            ),

            child:
                LinearProgressIndicator(
              value: percent,

              minHeight: 8,

              backgroundColor:
                  Colors.white
                      .withOpacity(
                .08,
              ),

              valueColor:
                  AlwaysStoppedAnimation(
                Colors.white
                    .withOpacity(
                  .90,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
