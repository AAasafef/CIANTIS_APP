import 'package:flutter/material.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_option_card.dart';
import '../../widgets/onboarding_page_shell.dart';

class QuickSetupStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const QuickSetupStep({
    super.key,
    required this.onNext,
  });

  @override
  State<QuickSetupStep>
      createState() =>
          _QuickSetupStepState();
}

class _QuickSetupStepState
    extends State<
        QuickSetupStep> {

  String selectedMode =
      'Balanced Life';

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 16,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Choose your starting mode',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Ciantis can instantly configure your dashboard around your current priorities.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          OnboardingOptionCard(
            title: 'Balanced Life',

            subtitle:
                'Wellness, family, productivity, and goals equally balanced.',

            selected:
                selectedMode ==
                    'Balanced Life',

            onTap: () {
              setState(() {
                selectedMode =
                    'Balanced Life';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Glow Up Era',

            subtitle:
                'Beauty, wellness, confidence, routines, and self-care focused.',

            selected:
                selectedMode ==
                    'Glow Up Era',

            onTap: () {
              setState(() {
                selectedMode =
                    'Glow Up Era';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Productivity Reset',

            subtitle:
                'Tasks, scheduling, routines, and deep focus prioritized.',

            selected:
                selectedMode ==
                    'Productivity Reset',

            onTap: () {
              setState(() {
                selectedMode =
                    'Productivity Reset';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Family First',

            subtitle:
                'Children, schedules, health, routines, and household systems prioritized.',

            selected:
                selectedMode ==
                    'Family First',

            onTap: () {
              setState(() {
                selectedMode =
                    'Family First';
              });
            },
          ),

          const Spacer(),

          OnboardingBottomButton(
            text: 'Finish Setup',

            onPressed:
                widget.onNext,
          ),
        ],
      ),
    );
  }
}
