import '../models/space_model.dart';
import 'available_spaces_data.dart';

final List<SpaceModel> defaultActiveSpaces =
    availableSpaces.where((space) {
  return [
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
  ].contains(space.id);
}).toList();