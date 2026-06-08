import 'package:flutter/material.dart';

import '../services/onboarding_service.dart';

import 'glass_container.dart';

class WelcomeBannerCard
    extends StatelessWidget {

  const WelcomeBannerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final onboarding =
        OnboardingService.instance;

    final String name =
        onboarding.profileName
                .trim()
                .isEmpty
            ? 'Shaverian'
            : onboarding.profileName;

    return GlassContainer(
      borderRadius: 30,

      padding:
          const EdgeInsets.all(
        24,
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
                  'Welcome back,',
                  style: TextStyle(
                    color:
                        Colors.white
                            .withOpacity(
                      .65,
                    ),

                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  name,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight:
                        FontWeight.w300,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  'Your personalized Life OS is ready for today.',
                  style: TextStyle(
                    color:
                        Colors.white
                            .withOpacity(
                      .72,
                    ),

                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          Container(
            height: 84,
            width: 84,

            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                28,
              ),

              gradient: LinearGradient(
                begin:
                    Alignment.topLeft,

                end:
                    Alignment.bottomRight,

                colors: [

                  Colors.white
                      .withOpacity(
                    .18,
                  ),

                  Colors.white
                      .withOpacity(
                    .04,
                  ),
                ],
              ),
            ),

            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 38,
            ),
          ),
        ],
      ),
    );
  }
}
