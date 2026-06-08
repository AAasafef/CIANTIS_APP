import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/available_spaces_data.dart';
import '../models/space_model.dart';

class SpacesService {
  static final SpacesService instance =
      SpacesService._internal();

  SpacesService._internal();

  static const String activeSpacesKey =
      'active_spaces';

  static const List<String> defaultActiveSpaceIds = [
    'documents',
    'health',
    'money',
    'business',
    'school',
    'work',
    'spiritual',
    'home',
    'beauty',
    'family',
    'library',
    'reserve',
  ];

  final List<SpaceModel> spaces =
      availableSpaces.map((space) {
    return SpaceModel(
      id: space.id,
      name: space.name,
      title: space.title,
      description: space.description,
      imagePath: space.imagePath,
      icon: space.icon,
      color: space.color,
      locked: space.locked,
      hidden: space.hidden,
      selected: defaultActiveSpaceIds.contains(space.id),
    );
  }).toList();

  List<SpaceModel> get activeSpaces {
    return spaces.where((space) {
      return space.selected;
    }).toList();
  }

  List<String> get activeSpaceIds {
    return activeSpaces.map((space) {
      return space.id;
    }).toList();
  }

  void toggleSpace(String id) {
    final index = spaces.indexWhere(
      (space) => space.id == id,
    );

    if (index == -1) return;

    spaces[index].selected =
        !spaces[index].selected;
  }

  Future<void> saveSelectedSpaces() async {
    await saveActiveSpaces(activeSpaceIds);
  }

  Future<void> loadSavedSpaces() async {
    final savedIds = await loadActiveSpaces();

    if (savedIds == null) return;

    for (final space in spaces) {
      space.selected = savedIds.contains(space.id);
    }
  }

  static Future<void> saveActiveSpaces(
    List<String> ids,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      activeSpacesKey,
      jsonEncode(ids),
    );
  }

  static Future<List<String>?> loadActiveSpaces()
      async {
    final prefs =
        await SharedPreferences.getInstance();

    final data =
        prefs.getString(activeSpacesKey);

    if (data == null) return null;

    return List<String>.from(
      jsonDecode(data),
    );
  }

  static Future<void> resetSpaces() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(activeSpacesKey);

    for (final space in instance.spaces) {
      space.selected =
          defaultActiveSpaceIds.contains(space.id);
    }
  }
}