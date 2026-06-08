import 'package:flutter/material.dart';

import '../dashboard/dashboard_screen.dart';

import 'ai_personality_step.dart';
import 'biometric_setup_step.dart';
import 'daily_rhythm_step.dart';
import 'dashboard_style_step.dart';
import 'final_setup_step.dart';
import 'focus_areas_step.dart';
import 'integrations_step.dart';
import 'menu_setup_step.dart';
import 'name_step.dart';
import 'notification_style_step.dart';
import 'privacy_preferences_step.dart';
import 'profile_photo_step.dart';
import 'quick_setup_step.dart';
import 'sync_preferences_step.dart';
import 'theme_step.dart';
import 'wallpaper_preferences_step.dart';
import 'welcome_animation_step.dart';
import 'widgets_layout_step.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({
    super.key,
  });

  @override
  State<OnboardingFlowScreen> createState() =>
      _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState
    extends State<OnboardingFlowScreen> {
  final PageController pageController =
      PageController();

  int currentPage = 0;

  late final List<Widget> pages = [
    WelcomeAnimationStep(
      onComplete: nextPage,
    ),

    NameStep(
      onNext: nextPage,
    ),

    ThemeStep(
      onNext: nextPage,
    ),

    FocusAreasStep(
      onNext: nextPage,
    ),

    MenuSetupStep(
      onNext: nextPage,
    ),

    NotificationStyleStep(
      onNext: nextPage,
    ),

    DashboardStyleStep(
      onNext: nextPage,
    ),

    BiometricSetupStep(
      onNext: nextPage,
    ),

    DailyRhythmStep(
      onNext: nextPage,
    ),

    ProfilePhotoStep(
      onNext: nextPage,
    ),

    AiPersonalityStep(
      onNext: nextPage,
    ),

    SyncPreferencesStep(
      onNext: nextPage,
    ),

    IntegrationsStep(
      onNext: nextPage,
    ),

    WallpaperPreferencesStep(
      onNext: nextPage,
    ),

    PrivacyPreferencesStep(
      onNext: nextPage,
    ),

    WidgetsLayoutStep(
      onNext: nextPage,
    ),

    QuickSetupStep(
      onNext: nextPage,
    ),

    FinalSetupStep(
      onFinish: finishSetup,
    ),
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      if (currentPage == 0) {
        pageController.jumpToPage(1);
      } else {
        pageController.nextPage(
          duration: const Duration(
            milliseconds: 420,
          ),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void skipSetup() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const DashboardScreen(),
      ),
    );
  }

  void finishSetup() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const DashboardScreen(),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics:
                const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: pages,
          ),

          if (currentPage > 0)
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    0,
                    18,
                    22,
                    0,
                  ),
                  child: GestureDetector(
                    onTap: skipSetup,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 16,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(.72),
                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),
                      ),
                      child: const Text(
                        'Skip Setup',
                        style: TextStyle(
                          color:
                              Color(0xFF2D241D),
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}