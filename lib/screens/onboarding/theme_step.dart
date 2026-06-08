import 'package:flutter/material.dart';

import '../../services/onboarding_service.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_option_card.dart';
import '../../widgets/onboarding_page_shell.dart';

class ThemeStep extends StatefulWidget {

  final VoidCallback onNext;

  const ThemeStep({
    super.key,
    required this.onNext,
  });

  @override
  State<ThemeStep> createState() =>
      _ThemeStepState();
}

class _ThemeStepState
    extends State<ThemeStep> {

  String selectedTheme =
      'Dune';

  void continueStep() {

    OnboardingService
        .instance
        .selectedTheme =
        selectedTheme;

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 2,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Choose your aesthetic',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Your aesthetic can always be changed later inside settings.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          OnboardingOptionCard(
            title: 'Dune',

            subtitle:
                'Warm taupes, soft luxury, calm minimalism.',

            selected:
                selectedTheme ==
                    'Dune',

            onTap: () {
              setState(() {
                selectedTheme =
                    'Dune';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Obsidian',

            subtitle:
                'Dark luxury with elevated contrast and elegance.',

            selected:
                selectedTheme ==
                    'Obsidian',

            onTap: () {
              setState(() {
                selectedTheme =
                    'Obsidian';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Evergreen',

            subtitle:
                'Nature-inspired wellness tones and soft greens.',

            selected:
                selectedTheme ==
                    'Evergreen',

            onTap: () {
              setState(() {
                selectedTheme =
                    'Evergreen';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Aurora',

            subtitle:
                'Airy gradients and soft glowing atmospheres.',

            selected:
                selectedTheme ==
                    'Aurora',

            onTap: () {
              setState(() {
                selectedTheme =
                    'Aurora';
              });
            },
          ),

          const Spacer(),

          OnboardingBottomButton(
            text: 'Continue',

            onPressed:
                continueStep,
          ),
        ],
      ),
    );
  }
}
