import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/tag_item.dart';

class TagService {
  TagService._();

  static final TagService instance =
      TagService._();

  static const String _storageKey =
      'ciantis_global_tags';

  final List<TagItem> _tags = [];

  List<TagItem> get tags {
    final sorted = [..._tags];

    sorted.sort(
      (a, b) => a.name.toLowerCase().compareTo(
            b.name.toLowerCase(),
          ),
    );

    return sorted;
  }

  Future<void> load() async {
    final prefs =
        await SharedPreferences.getInstance();

    final rawList =
        prefs.getStringList(_storageKey) ?? [];

    _tags
      ..clear()
      ..addAll(
        rawList.map((raw) {
          final decoded =
              jsonDecode(raw) as Map<String, dynamic>;

          return TagItem.fromJson(decoded);
        }),
      );
  }

  Future<void> addTag(String name) async {
    final cleanName = name.trim();

    if (cleanName.isEmpty) return;

    final alreadyExists = _tags.any(
      (tag) =>
          tag.name.toLowerCase() ==
          cleanName.toLowerCase(),
    );

    if (alreadyExists) return;

    _tags.add(
      TagItem(
        id: DateTime.now()
            .microsecondsSinceEpoch
            .toString(),
        name: cleanName,
        createdAt: DateTime.now(),
      ),
    );

    await _save();
  }

  Future<void> deleteTag(String id) async {
    _tags.removeWhere(
      (tag) => tag.id == id,
    );

    await _save();
  }

  Future<void> renameTag({
    required String id,
    required String newName,
  }) async {
    final index = _tags.indexWhere(
      (tag) => tag.id == id,
    );

    if (index == -1) return;

    final cleanName = newName.trim();

    if (cleanName.isEmpty) return;

    _tags[index] = TagItem(
      id: _tags[index].id,
      name: cleanName,
      createdAt: _tags[index].createdAt,
    );

    await _save();
  }

  Future<List<TagItem>> search(String query) async {
    await load();

    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      return tags;
    }

    return tags.where((tag) {
      return tag.name.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> seedDefaultTags() async {
    await load();

    final defaults = [
      'Important',
      'Personal',
      'Business',
      'Family',
      'Kids',
      'Health',
      'Medical',
      'Bills',
      'Taxes',
      'Receipts',
      'School',
      'Nursing',
      'Salon',
      'Beauty',
      'Spiritual',
      'Prayer',
      'Goals',
      'Documents',
      'Calendar',
      'Urgent',
    ];

    for (final tag in defaults) {
      await addTag(tag);
    }
  }

  Future<void> _save() async {
    final prefs =
        await SharedPreferences.getInstance();

    final rawList = _tags.map((tag) {
      return jsonEncode(tag.toJson());
    }).toList();

    await prefs.setStringList(
      _storageKey,
      rawList,
    );
  }
}