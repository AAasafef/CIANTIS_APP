import 'package:flutter/material.dart';

import '../services/onboarding_service.dart';

import 'profile_avatar.dart';

class DashboardHeader
    extends StatelessWidget {

  const DashboardHeader({
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

    final String subtitle =
        onboarding.subtitle
                .trim()
                .isEmpty
            ? 'Welcome back'
            : onboarding.subtitle;

    return Row(
      children: [

        const ProfileAvatar(),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                'Good Evening,',

                style: TextStyle(
                  color:
                      Colors.white
                          .withOpacity(
                    .70,
                  ),

                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                name,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight:
                      FontWeight.w300,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,

                style: TextStyle(
                  color:
                      Colors.white
                          .withOpacity(
                    .55,
                  ),

                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 46,
          width: 46,

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

            border: Border.all(
              color:
                  Colors.white
                      .withOpacity(
                .08,
              ),
            ),
          ),

          child: const Icon(
            Icons.notifications_none,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
