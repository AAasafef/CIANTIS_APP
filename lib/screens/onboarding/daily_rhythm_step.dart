import 'package:flutter/material.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_option_card.dart';
import '../../widgets/onboarding_page_shell.dart';

class DailyRhythmStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const DailyRhythmStep({
    super.key,
    required this.onNext,
  });

  @override
  State<DailyRhythmStep>
      createState() =>
          _DailyRhythmStepState();
}

class _DailyRhythmStepState
    extends State<
        DailyRhythmStep> {

  String selectedRhythm =
      'Balanced';

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 8,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'What is your daily rhythm?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Ciantis will personalize routines, reminders, and scheduling around your natural lifestyle flow.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          OnboardingOptionCard(
            title: 'Morning Focused',

            subtitle:
                'Early productivity, routines, and structured mornings.',

            selected:
                selectedRhythm ==
                    'Morning Focused',

            onTap: () {
              setState(() {
                selectedRhythm =
                    'Morning Focused';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Night Owl',

            subtitle:
                'Late-night creativity, flexible mornings, and evening productivity.',

            selected:
                selectedRhythm ==
                    'Night Owl',

            onTap: () {
              setState(() {
                selectedRhythm =
                    'Night Owl';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Balanced',

            subtitle:
                'Flexible structure throughout the day with balanced energy management.',

            selected:
                selectedRhythm ==
                    'Balanced',

            onTap: () {
              setState(() {
                selectedRhythm =
                    'Balanced';
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
