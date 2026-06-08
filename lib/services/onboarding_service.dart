class OnboardingService {

  static final OnboardingService
      instance =
      OnboardingService._internal();

  OnboardingService._internal();

  bool onboardingCompleted =
      false;

  String profileName = '';

  String subtitle = '';

  String selectedTheme =
      'Dune';

  String dashboardStyle =
      'Life Overview';

  String aiTone =
      'Encouraging';

  String wallpaperStyle =
      'Nature';

  String widgetLayout =
      'Balanced';

  List<String> selectedTabs = [

    'Dashboard',
    'Calendar',
    'Family',
  ];

  List<String> focusAreas = [];

  List<String> integrations = [];

  void completeOnboarding() {
    onboardingCompleted = true;
  }

  void resetOnboarding() {

    onboardingCompleted =
        false;

    profileName = '';

    subtitle = '';

    selectedTabs = [

      'Dashboard',
      'Calendar',
      'Family',
    ];

    focusAreas = [];

    integrations = [];
  }
}
