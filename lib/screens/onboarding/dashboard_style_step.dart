import 'package:flutter/material.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_option_card.dart';
import '../../widgets/onboarding_page_shell.dart';

class DashboardStyleStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const DashboardStyleStep({
    super.key,
    required this.onNext,
  });

  @override
  State<DashboardStyleStep>
      createState() =>
          _DashboardStyleStepState();
}

class _DashboardStyleStepState
    extends State<
        DashboardStyleStep> {

  String selectedStyle =
      'Life Overview';

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 6,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Choose dashboard style',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Your dashboard layout controls how information is prioritized throughout the app.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          OnboardingOptionCard(
            title: 'Life Overview',

            subtitle:
                'Balanced wellness, goals, family, and productivity overview.',

            selected:
                selectedStyle ==
                    'Life Overview',

            onTap: () {
              setState(() {
                selectedStyle =
                    'Life Overview';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Focus Mode',

            subtitle:
                'Minimal distractions with priority tasks and routines first.',

            selected:
                selectedStyle ==
                    'Focus Mode',

            onTap: () {
              setState(() {
                selectedStyle =
                    'Focus Mode';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Productivity',

            subtitle:
                'Task-driven workspace with analytics and scheduling emphasis.',

            selected:
                selectedStyle ==
                    'Productivity',

            onTap: () {
              setState(() {
                selectedStyle =
                    'Productivity';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Wellness',

            subtitle:
                'Health, mindfulness, nutrition, and emotional balance prioritized.',

            selected:
                selectedStyle ==
                    'Wellness',

            onTap: () {
              setState(() {
                selectedStyle =
                    'Wellness';
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
