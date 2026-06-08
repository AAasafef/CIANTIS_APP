import 'package:flutter/material.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_page_shell.dart';

class ProfilePhotoStep
    extends StatelessWidget {

  final VoidCallback onNext;

  const ProfilePhotoStep({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 9,
      totalSteps: 18,

      onSkip:
          onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center,

        children: [

          const Spacer(),

          const Text(
            'Add a profile photo',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Personalize your dashboard and create a more connected experience.',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 44),

          Container(
            height: 160,
            width: 160,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color:
                  Colors.white
                      .withOpacity(
                .10,
              ),

              border: Border.all(
                color:
                    Colors.white,
                width: 1.5,
              ),
            ),

            child: const Center(
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white70,
              ),
            ),
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            height: 58,

            child: OutlinedButton.icon(
              onPressed: () {},

              style:
                  OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Colors.white
                      .withOpacity(
                    .4,
                  ),
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    22,
                  ),
                ),
              ),

              icon: const Icon(
                Icons.photo_library_outlined,
                color: Colors.white,
              ),

              label: const Text(
                'Choose Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          const Spacer(),

          OnboardingBottomButton(
            text: 'Continue',

            onPressed:
                onNext,
          ),
        ],
      ),
    );
  }
}
