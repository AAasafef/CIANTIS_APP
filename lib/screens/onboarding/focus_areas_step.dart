import 'package:flutter/material.dart';

import '../../services/onboarding_service.dart';

import '../../widgets/category_picker_chip.dart';
import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_page_shell.dart';

class FocusAreasStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const FocusAreasStep({
    super.key,
    required this.onNext,
  });

  @override
  State<FocusAreasStep>
      createState() =>
          _FocusAreasStepState();
}

class _FocusAreasStepState
    extends State<
        FocusAreasStep> {

  final List<String> selectedAreas =
      [];

  final List<String> areas = [

    'Family',
    'Health',
    'Goals',
    'Habits',
    'Nutrition',
    'Beauty',
    'Wellness',
    'Finances',
    'Business',
    'Learning',
    'Self Care',
    'Spiritual',
  ];

  void toggleArea(
    String area,
  ) {

    setState(() {

      if (selectedAreas.contains(
        area,
      )) {

        selectedAreas.remove(area);

      } else {

        selectedAreas.add(area);
      }
    });
  }

  void continueStep() {

    OnboardingService
        .instance
        .focusAreas =
        selectedAreas;

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 3,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Choose your focus areas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Select the areas that matter most to your lifestyle and goals.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 34),

          Wrap(
            spacing: 14,
            runSpacing: 14,

            children:
                areas.map((area) {

              return CategoryPickerChip(
                text: area,

                selected:
                    selectedAreas
                        .contains(
                  area,
                ),

                onTap: () {
                  toggleArea(
                    area,
                  );
                },
              );
            }).toList(),
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
