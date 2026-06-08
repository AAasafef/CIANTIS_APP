import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_item.dart';

class NotificationsService extends ChangeNotifier {
  static final NotificationsService instance =
      NotificationsService._internal();

  NotificationsService._internal();

  static const String _storageKey =
      'ciantis_notifications';

  final List<NotificationItem>
      _notifications = [];

  bool _loaded = false;

  Future<void> initialize() async {
    if (_loaded) return;

    final prefs =
        await SharedPreferences.getInstance();

    final rawList =
        prefs.getStringList(
              _storageKey,
            ) ??
            [];

    _notifications
      ..clear()
      ..addAll(
        rawList.map((raw) {
          final decoded =
              jsonDecode(raw)
                  as Map<String, dynamic>;

          return NotificationItem.fromMap(
            decoded,
          );
        }),
      );

    _loaded = true;

    notifyListeners();
  }

  Future<void> _save() async {
    final prefs =
        await SharedPreferences.getInstance();

    final rawList =
        _notifications.map((notification) {
      return jsonEncode(
        notification.toMap(),
      );
    }).toList();

    await prefs.setStringList(
      _storageKey,
      rawList,
    );
  }

  List<NotificationItem>
      get notifications {
    final copy = [
      ..._notifications,
    ];

    copy.sort((a, b) {
      return b.createdAt.compareTo(
        a.createdAt,
      );
    });

    return copy;
  }

  int get unreadCount {
    return _notifications.where(
      (notification) {
        return !notification.isRead;
      },
    ).length;
  }

  Future<void> addNotification({
    required String title,
    required String message,
    required String type,
  }) async {
    await initialize();

    final notification =
        NotificationItem(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      title: title,
      message: message,
      type: type,
      createdAt: DateTime.now(),
    );

    _notifications.insert(
      0,
      notification,
    );

    await _save();

    notifyListeners();
  }

  Future<void> markAsRead(
    String id,
  ) async {
    final index = _notifications
        .indexWhere(
      (notification) =>
          notification.id == id,
    );

    if (index == -1) return;

    _notifications[index] =
        _notifications[index].copyWith(
      isRead: true,
    );

    await _save();

    notifyListeners();
  }

  Future<void> markAllAsRead() async {
    for (
      int i = 0;
      i < _notifications.length;
      i++
    ) {
      _notifications[i] =
          _notifications[i].copyWith(
        isRead: true,
      );
    }

    await _save();

    notifyListeners();
  }

  Future<void> deleteNotification(
    String id,
  ) async {
    _notifications.removeWhere(
      (notification) =>
          notification.id == id,
    );

    await _save();

    notifyListeners();
  }

  Future<void> clearAll() async {
    _notifications.clear();

    await _save();

    notifyListeners();
  }
}