import 'package:flutter/material.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_option_card.dart';
import '../../widgets/onboarding_page_shell.dart';

class BiometricSetupStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const BiometricSetupStep({
    super.key,
    required this.onNext,
  });

  @override
  State<BiometricSetupStep>
      createState() =>
          _BiometricSetupStepState();
}

class _BiometricSetupStepState
    extends State<
        BiometricSetupStep> {

  String selectedOption =
      'Face ID';

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 7,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Secure your Life OS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Choose how you would like to protect your personal dashboard and documents.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          OnboardingOptionCard(
            title: 'Face ID',

            subtitle:
                'Quick and secure facial authentication.',

            selected:
                selectedOption ==
                    'Face ID',

            onTap: () {
              setState(() {
                selectedOption =
                    'Face ID';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Fingerprint',

            subtitle:
                'Biometric fingerprint security.',

            selected:
                selectedOption ==
                    'Fingerprint',

            onTap: () {
              setState(() {
                selectedOption =
                    'Fingerprint';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Passcode Only',

            subtitle:
                'Traditional PIN or passcode security.',

            selected:
                selectedOption ==
                    'Passcode Only',

            onTap: () {
              setState(() {
                selectedOption =
                    'Passcode Only';
              });
            },
          ),

          const Spacer(),

          OnboardingBottomButton(
            text: 'Continue',

            onPressed:
                widget.onNext,
          ),
        ],
      ),
    );
  }
}
