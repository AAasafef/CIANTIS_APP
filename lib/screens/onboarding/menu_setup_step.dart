import 'package:flutter/material.dart';

import '../../services/onboarding_service.dart';

import '../../widgets/category_picker_chip.dart';
import '../../widgets/onboarding_bottom_button.dart';
import '../../widgets/onboarding_page_shell.dart';

class MenuSetupStep
    extends StatefulWidget {

  final VoidCallback onNext;

  const MenuSetupStep({
    super.key,
    required this.onNext,
  });

  @override
  State<MenuSetupStep>
      createState() =>
          _MenuSetupStepState();
}

class _MenuSetupStepState
    extends State<MenuSetupStep> {

  final List<String> selectedTabs = [

    'Dashboard',
    'Calendar',
    'Family',
  ];

  final List<String> availableTabs = [

    'Dashboard',
    'Calendar',
    'Family',
    'Goals',
    'Habits',
    'Health',
    'Nutrition',
    'Finances',
    'Journal',
    'Documents',
    'Learning',
    'Beauty',
    'Wellness',
    'Business',
    'Shopping',
    'Travel',
  ];

  void toggleTab(
    String tab,
  ) {

    setState(() {

      if (selectedTabs.contains(
        tab,
      )) {

        selectedTabs.remove(tab);

      } else {

        if (selectedTabs.length <
            10) {

          selectedTabs.add(tab);
        }
      }
    });
  }

  void continueStep() {

    OnboardingService
        .instance
        .selectedTabs =
        selectedTabs;

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      currentStep: 4,
      totalSteps: 18,

      onSkip:
          widget.onNext,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Spacer(),

          const Text(
            'Build your side menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w300,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Choose up to 10 categories for your Life OS. You can always customize this later.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            '${selectedTabs.length}/10 selected',

            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 28),

          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 14,
                runSpacing: 14,

                children:
                    availableTabs.map(
                  (tab) {

                    return CategoryPickerChip(
                      text: tab,

                      selected:
                          selectedTabs
                              .contains(
                        tab,
                      ),

                      onTap: () {
                        toggleTab(
                          tab,
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
                continueStep,
          ),
        ],
      ),
    );
  }
}
