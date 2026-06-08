import 'package:shared_preferences/shared_preferences.dart';

class TutorialService {
  static final TutorialService instance =
      TutorialService._internal();

  TutorialService._internal();

  static const String spacesTutorialKey =
      'has_seen_spaces_tutorial';

  bool hasSeenSpacesTutorial = false;

  Future<void> loadTutorials() async {
    final prefs =
        await SharedPreferences.getInstance();

    hasSeenSpacesTutorial =
        prefs.getBool(spacesTutorialKey) ?? false;
  }

  Future<void> completeSpacesTutorial() async {
    hasSeenSpacesTutorial = true;

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      spacesTutorialKey,
      true,
    );
  }

  Future<void> resetTutorials() async {
    hasSeenSpacesTutorial = false;

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(spacesTutorialKey);
  }
}