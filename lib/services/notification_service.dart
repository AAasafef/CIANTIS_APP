import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_item.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
      NotificationService._();

  static const String _storageKey =
      'ciantis_notification_items';

  final List<NotificationItem> _items = [];

  List<NotificationItem> get items {
    final sorted = [..._items];

    sorted.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    return sorted;
  }

  List<NotificationItem> get unreadItems {
    return items.where((item) {
      return !item.read;
    }).toList();
  }

  int get unreadCount {
    return unreadItems.length;
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

          return NotificationItem.fromJson(decoded);
        }),
      );
  }

  Future<void> addNotification({
    required String title,
    required String message,
    required String type,
    required String spaceId,
    required String spaceName,
    DateTime? scheduledFor,
  }) async {
    final item = NotificationItem(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      title: title,
      message: message,
      type: type,
      spaceId: spaceId,
      spaceName: spaceName,
      createdAt: DateTime.now(),
      scheduledFor: scheduledFor,
    );

    _items.add(item);

    await _save();
  }

  Future<void> markRead(String id) async {
    final index = _items.indexWhere(
      (item) => item.id == id,
    );

    if (index == -1) return;

    _items[index] =
        _items[index].copyWith(read: true);

    await _save();
  }

  Future<void> markAllRead() async {
    for (int i = 0; i < _items.length; i++) {
      _items[i] = _items[i].copyWith(read: true);
    }

    await _save();
  }

  Future<void> deleteNotification(String id) async {
    _items.removeWhere(
      (item) => item.id == id,
    );

    await _save();
  }

  Future<void> clearAll() async {
    _items.clear();

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