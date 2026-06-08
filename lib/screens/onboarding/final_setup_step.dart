import 'package:flutter/material.dart';

import '../../services/onboarding_service.dart';

import '../../widgets/completion_ring.dart';
import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_page_shell.dart';

class FinalSetupStep
    extends StatefulWidget {

  final VoidCallback onFinish;

  const FinalSetupStep({
    super.key,
    required this.onFinish,
  });

  @override
  State<FinalSetupStep>
      createState() =>
          _FinalSetupStepState();
}

class _FinalSetupStepState
    extends State<FinalSetupStep> {

  double progress = .82;

  void finishSetup() {

    OnboardingService
        .instance
        .completeOnboarding();

    widget.onFinish();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 17,
      totalSteps: 18,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center,

        children: [

          const Spacer(),

          CompletionRing(
            progress: progress,
          ),

          const SizedBox(height: 34),

          const Text(
            'Preparing your Life OS',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Configuring your dashboard, modules, themes, routines, and personalized experience.',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const Spacer(),

          Column(
            children: [

              _setupItem(
                'Initializing dashboard',
              ),

              _setupItem(
                'Configuring modules',
              ),

              _setupItem(
                'Applying aesthetic',
              ),

              _setupItem(
                'Preparing wellness systems',
              ),
            ],
          ),

          const Spacer(),

          OnboardingBottomButton(
            text: 'Enter Ciantis',

            onPressed:
                finishSetup,
          ),
        ],
      ),
    );
  }

  Widget _setupItem(
    String text,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: Row(
        children: [

          const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 20,
          ),

          const SizedBox(width: 14),

          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
