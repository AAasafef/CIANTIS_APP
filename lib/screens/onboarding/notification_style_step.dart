import 'package:flutter/material.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_option_card.dart';
import '../../widgets/onboarding_page_shell.dart';

class NotificationStyleStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const NotificationStyleStep({
    super.key,
    required this.onNext,
  });

  @override
  State<NotificationStyleStep>
      createState() =>
          _NotificationStyleStepState();
}

class _NotificationStyleStepState
    extends State<
        NotificationStyleStep> {

  String selectedStyle =
      'Balanced';

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 5,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Choose notification style',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Decide how involved Ciantis should be throughout your day.',
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
                'Only important reminders and critical updates.',

            selected:
                selectedStyle ==
                    'Minimal',

            onTap: () {
              setState(() {
                selectedStyle =
                    'Minimal';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Balanced',

            subtitle:
                'Helpful reminders without becoming overwhelming.',

            selected:
                selectedStyle ==
                    'Balanced',

            onTap: () {
              setState(() {
                selectedStyle =
                    'Balanced';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Detailed',

            subtitle:
                'Full coaching, wellness insights, and productivity guidance.',

            selected:
                selectedStyle ==
                    'Detailed',

            onTap: () {
              setState(() {
                selectedStyle =
                    'Detailed';
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
