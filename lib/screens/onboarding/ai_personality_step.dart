import 'package:flutter/material.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_option_card.dart';
import '../../widgets/onboarding_page_shell.dart';

class AiPersonalityStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const AiPersonalityStep({
    super.key,
    required this.onNext,
  });

  @override
  State<AiPersonalityStep>
      createState() =>
          _AiPersonalityStepState();
}

class _AiPersonalityStepState
    extends State<
        AiPersonalityStep> {

  String selectedPersonality =
      'Encouraging';

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 10,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Choose your AI tone',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Your assistant personality controls how Ciantis communicates throughout the app.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          OnboardingOptionCard(
            title: 'Encouraging',

            subtitle:
                'Supportive, uplifting, and motivating guidance.',

            selected:
                selectedPersonality ==
                    'Encouraging',

            onTap: () {
              setState(() {
                selectedPersonality =
                    'Encouraging';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Luxury Concierge',

            subtitle:
                'Elegant, calm, refined assistance with premium tone.',

            selected:
                selectedPersonality ==
                    'Luxury Concierge',

            onTap: () {
              setState(() {
                selectedPersonality =
                    'Luxury Concierge';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Focused Coach',

            subtitle:
                'Structured accountability and productivity-first communication.',

            selected:
                selectedPersonality ==
                    'Focused Coach',

            onTap: () {
              setState(() {
                selectedPersonality =
                    'Focused Coach';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Minimal',

            subtitle:
                'Quiet, clean, and only essential interactions.',

            selected:
                selectedPersonality ==
                    'Minimal',

            onTap: () {
              setState(() {
                selectedPersonality =
                    'Minimal';
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
