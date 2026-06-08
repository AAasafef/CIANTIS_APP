import 'package:flutter/material.dart';

import '../../widgets/glass_container.dart';
import '../../widgets/onboarding_background.dart';
import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_progress_bar.dart';
import '../../widgets/onboarding_skip_button.dart';

class WelcomeStep extends StatelessWidget {

  final VoidCallback onNext;

  const WelcomeStep({
    super.key,
    required this.onNext,
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

                // TOP
                Row(
                  children: [

                    const Expanded(
                      child:
                          OnboardingProgressBar(
                        currentStep: 0,
                        totalSteps: 18,
                      ),
                    ),

                    const SizedBox(width: 12),

                    OnboardingSkipButton(
                      onTap: onNext,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // LOGO
                Center(
                  child: GlassContainer(
                    padding:
                        const EdgeInsets.all(
                      20,
                    ),

                    borderRadius: 28,

                    child: const Text(
                      'C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight:
                            FontWeight.w300,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                const Text(
                  'Welcome to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.w300,
                  ),
                ),

                const Text(
                  'ciantis',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight:
                        FontWeight.w300,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Your personal operating system for clarity, focus, family, and growth.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),

                const Spacer(),

                OnboardingBottomButton(
                  text: 'Begin',

                  onPressed: onNext,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
