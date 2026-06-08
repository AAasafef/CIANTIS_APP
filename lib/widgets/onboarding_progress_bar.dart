import 'package:flutter/material.dart';

class OnboardingProgressBar
    extends StatelessWidget {

  final int currentStep;

  final int totalSteps;

  const OnboardingProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: List.generate(
        totalSteps,
        (index) {

          final isActive =
              index <= currentStep;

          return Expanded(
            child: AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 300,
              ),

              margin:
                  const EdgeInsets.only(
                right: 6,
              ),

              height: 6,

              decoration: BoxDecoration(
                color: isActive
                    ? Colors.white
                    : Colors.white
                        .withOpacity(
                        .18,
                      ),

                borderRadius:
                    BorderRadius.circular(
                  100,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
