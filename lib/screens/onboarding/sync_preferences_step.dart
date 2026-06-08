import 'package:flutter/material.dart';

import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_option_card.dart';
import '../../widgets/onboarding_page_shell.dart';

class SyncPreferencesStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const SyncPreferencesStep({
    super.key,
    required this.onNext,
  });

  @override
  State<SyncPreferencesStep>
      createState() =>
          _SyncPreferencesStepState();
}

class _SyncPreferencesStepState
    extends State<
        SyncPreferencesStep> {

  String selectedPreference =
      'Cloud Sync';

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 11,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Choose sync preferences',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Control how your data, routines, goals, and personalization settings are stored.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 36),

          OnboardingOptionCard(
            title: 'Cloud Sync',

            subtitle:
                'Automatically back up and sync your experience across devices.',

            selected:
                selectedPreference ==
                    'Cloud Sync',

            onTap: () {
              setState(() {
                selectedPreference =
                    'Cloud Sync';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Ask Before Syncing',

            subtitle:
                'Receive prompts before syncing important data.',

            selected:
                selectedPreference ==
                    'Ask Before Syncing',

            onTap: () {
              setState(() {
                selectedPreference =
                    'Ask Before Syncing';
              });
            },
          ),

          OnboardingOptionCard(
            title: 'Offline Only',

            subtitle:
                'Keep all information stored locally on your device only.',

            selected:
                selectedPreference ==
                    'Offline Only',

            onTap: () {
              setState(() {
                selectedPreference =
                    'Offline Only';
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
