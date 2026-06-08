import 'package:flutter/material.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_option_card.dart';
import '../../widgets/onboarding_page_shell.dart';

class WidgetsLayoutStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const WidgetsLayoutStep({
    super.key,
    required this.onNext,
  });

  @override
  State<WidgetsLayoutStep>
      createState() =>
          _WidgetsLayoutStepState();
}

class _WidgetsLayoutStepState
    extends State<
        WidgetsLayoutStep> {

  String selectedLayout =
      'Balanced';

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 15,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Choose widget layout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'This controls how information appears throughout your dashboard and home screens.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          OnboardingOptionCard(
            title: 'Minimal',

            subtitle:
                'Large spacing, fewer widgets, and calm visual hierarchy.',

            selected:
                selectedLayout ==
                    'Minimal',

            onTap: () {
              setState(() {
                selectedLayout =
                    'Minimal';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Balanced',

            subtitle:
                'Balanced dashboard with wellness, goals, and productivity sections.',

            selected:
                selectedLayout ==
                    'Balanced',

            onTap: () {
              setState(() {
                selectedLayout =
                    'Balanced';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Information Dense',

            subtitle:
                'More widgets, analytics, quick actions, and detailed organization.',

            selected:
                selectedLayout ==
                    'Information Dense',

            onTap: () {
              setState(() {
                selectedLayout =
                    'Information Dense';
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
