import 'package:flutter/material.dart';

import '../../widgets/category_picker_chip.dart';
import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_page_shell.dart';

class IntegrationsStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const IntegrationsStep({
    super.key,
    required this.onNext,
  });

  @override
  State<IntegrationsStep>
      createState() =>
          _IntegrationsStepState();
}

class _IntegrationsStepState
    extends State<
        IntegrationsStep> {

  final List<String>
      selectedIntegrations = [];

  final List<String> integrations = [

    'Google Calendar',
    'Apple Health',
    'Spotify',
    'Notion',
    'Google Drive',
    'Dropbox',
    'Gmail',
    'Apple Reminders',
    'Google Tasks',
    'Fitbit',
    'Samsung Health',
    'Google Photos',
  ];

  void toggleIntegration(
    String integration,
  ) {

    setState(() {

      if (selectedIntegrations
          .contains(
        integration,
      )) {

        selectedIntegrations
            .remove(
          integration,
        );

      } else {

        selectedIntegrations
            .add(
          integration,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 12,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Connect your apps',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Optional integrations help Ciantis organize your routines, wellness, scheduling, and productivity.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 34),

          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 14,
                runSpacing: 14,

                children:
                    integrations.map(
                  (
                    integration,
                  ) {

                    return CategoryPickerChip(
                      text:
                          integration,

                      selected:
                          selectedIntegrations
                              .contains(
                        integration,
                      ),

                      onTap: () {
                        toggleIntegration(
                          integration,
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ),
          ),

          const SizedBox(height: 24),

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
