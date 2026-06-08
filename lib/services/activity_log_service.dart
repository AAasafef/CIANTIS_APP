import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/activity_log_item.dart';

class ActivityLogService {
  ActivityLogService._();

  static final ActivityLogService instance =
      ActivityLogService._();

  static const String _storageKey =
      'ciantis_activity_log_items';

  final List<ActivityLogItem> _items = [];

  List<ActivityLogItem> get items {
    final sorted = _items.where((item) {
      return !item.isDeleted;
    }).toList();

    sorted.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    return sorted;
  }

  List<ActivityLogItem> get deletedItems {
    final sorted = _items.where((item) {
      return item.isDeleted;
    }).toList();

    sorted.sort(
      (a, b) {
        final aDeleted =
            a.deletedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDeleted =
            b.deletedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

        return bDeleted.compareTo(aDeleted);
      },
    );

    return sorted;
  }

  Future<void> load() async {
    final prefs =
        await SharedPreferences.getInstance();

    final rawList =
        prefs.getStringList(_storageKey) ?? [];

    _items
      ..clear()
      ..addAll(
        rawList.map((raw) {
          final decoded =
              jsonDecode(raw) as Map<String, dynamic>;

          return ActivityLogItem.fromJson(decoded);
        }),
      );
  }

  Future<void> addActivity({
    required String title,
    required String description,
    required String spaceId,
    required String spaceName,
    required String actionType,
  }) async {
    final item = ActivityLogItem(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      title: title,
      description: description,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: actionType,
      createdAt: DateTime.now(),
    );

    _items.add(item);

    await _save();
  }

  Future<void> softDelete(String id) async {
    final index = _items.indexWhere(
      (item) => item.id == id,
    );

    if (index == -1) return;

    _items[index] = _items[index].copyWith(
      deletedAt: DateTime.now(),
    );

    await _save();
  }

  Future<void> restore(String id) async {
    final index = _items.indexWhere(
      (item) => item.id == id,
    );

    if (index == -1) return;

    _items[index] = _items[index].copyWith(
      clearDeletedAt: true,
    );

    await _save();
  }

  Future<void> permanentlyDelete(String id) async {
    _items.removeWhere(
      (item) => item.id == id,
    );

    await _save();
  }

  Future<void> clearActive() async {
    for (int i = 0; i < _items.length; i++) {
      if (!_items[i].isDeleted) {
        _items[i] = _items[i].copyWith(
          deletedAt: DateTime.now(),
        );
      }
    }

    await _save();
  }

  Future<void> clearDeletedForever() async {
    _items.removeWhere(
      (item) => item.isDeleted,
    );

    await _save();
  }

  Future<void> _save() async {
    final prefs =
        await SharedPreferences.getInstance();

    final rawList = _items.map((item) {
      return jsonEncode(item.toJson());
    }).toList();

    await prefs.setStringList(
      _storageKey,
      rawList,
    );
  }
}