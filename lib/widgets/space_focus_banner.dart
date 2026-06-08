import 'package:flutter/material.dart';

class SpaceFocusBanner
    extends StatelessWidget {

  final String title;

  final String subtitle;

  const SpaceFocusBanner({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(
        24,
      ),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(
          30,
        ),

        gradient: LinearGradient(
          begin:
              Alignment.topLeft,

          end:
              Alignment.bottomRight,

          colors: [

            const Color(
              0xFFEDE3D6,
            ),

            const Color(
              0xFFF8F3EC,
            ),
          ],
        ),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black
                    .withOpacity(
              .04,
            ),

            blurRadius: 18,

            offset:
                const Offset(
              0,
              10,
            ),
          ),
        ],
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
                  title,

                  style:
                      const TextStyle(
                    color:
                        Color(
                      0xFF2D241D,
                    ),

                    fontSize: 26,

                    fontWeight:
                        FontWeight
                            .w300,

                    letterSpacing:
                        -.6,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  subtitle,

                  style:
                      TextStyle(
                    color:
                        Colors.black
                            .withOpacity(
                      .60,
                    ),

                    fontSize: 14,

                    height:
                        1.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 18,
          ),

          Container(
            height: 64,
            width: 64,

            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                22,
              ),

              color:
                  Colors.white,
            ),

            child: const Icon(
              Icons.auto_awesome,

              color:
                  Color(
                0xFF6E5846,
              ),

              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}