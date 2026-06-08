import 'package:flutter/material.dart';

import '../../services/onboarding_service.dart';

import '../../widgets/luxury_text_field.dart';
import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_page_shell.dart';

class NameStep extends StatefulWidget {

  final VoidCallback onNext;

  const NameStep({
    super.key,
    required this.onNext,
  });

  @override
  State<NameStep> createState() =>
      _NameStepState();
}

class _NameStepState
    extends State<NameStep> {

  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      subtitleController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    subtitleController.dispose();

    super.dispose();
  }

  void continueStep() {

    OnboardingService
        .instance
        .profileName =
        nameController.text;

    OnboardingService
        .instance
        .subtitle =
        subtitleController.text;

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 1,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Tell us about you',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Personalize your experience and create your luxury life system.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 40),

          LuxuryTextField(
            hintText:
                'Preferred Name',

            icon:
                Icons.person_outline,

            controller:
                nameController,
          ),

          const SizedBox(height: 18),

          LuxuryTextField(
            hintText:
                'Subtitle or Motto',

            icon:
                Icons.edit_outlined,

            controller:
                subtitleController,
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
