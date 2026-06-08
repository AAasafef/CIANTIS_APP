import 'package:flutter/material.dart';

import 'glass_container.dart';

class DateWeatherCard
    extends StatelessWidget {

  const DateWeatherCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 28,

      padding:
          const EdgeInsets.all(
        22,
      ),

      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  'Wednesday',
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
                  'May 13',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight:
                        FontWeight.w300,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Perfect day for a reset and focused routines.',
                  style: TextStyle(
                    color:
                        Colors.white
                            .withOpacity(
                      .70,
                    ),

                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          Column(
            children: [

              const Icon(
                Icons.wb_sunny_outlined,
                color: Colors.white,
                size: 42,
              ),

              const SizedBox(height: 10),

              const Text(
                '82°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight:
                      FontWeight.w300,
                ),
              ),

              Text(
                'Clear',
                style: TextStyle(
                  color:
                      Colors.white
                          .withOpacity(
                    .65,
                  ),

                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
