import 'package:flutter/material.dart';

import 'onboarding_background.dart';
import 'onboarding_progress_bar.dart';
import 'onboarding_skip_button.dart';

class OnboardingPageShell
    extends StatelessWidget {

  final int currentStep;

  final int totalSteps;

  final Widget child;

  final VoidCallback? onSkip;

  const OnboardingPageShell({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.child,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingBackground(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),

            child: Column(
              children: [

                // TOP BAR
                Row(
                  children: [

                    Expanded(
                      child:
                          OnboardingProgressBar(
                        currentStep:
                            currentStep,

                        totalSteps:
                            totalSteps,
                      ),
                    ),

                    if (onSkip != null) ...[

                      const SizedBox(
                        width: 12,
                      ),

                      OnboardingSkipButton(
                        onTap: onSkip!,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
