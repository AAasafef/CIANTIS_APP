import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'calendar_entry_model.dart';

class CalendarEntryService {
  CalendarEntryService._();

  static const String _storageKey =
      'ciantis_calendar_entries';

  static final List<CalendarEntry> _entries = [];

  static bool _loaded = false;

  static Future<void> loadEntries() async {
    if (_loaded) return;

    final prefs =
        await SharedPreferences.getInstance();

    final raw =
        prefs.getStringList(_storageKey) ?? [];

    _entries.clear();

    for (final item in raw) {
      final map =
          jsonDecode(item) as Map<String, dynamic>;

      _entries.add(
        CalendarEntry(
          id: map['id'],
          type: map['type'],
          title: map['title'],
          notes: map['notes'],
          location: map['location'],
          meetingLink: map['meetingLink'],
          startDateTime:
              DateTime.parse(map['startDateTime']),
          endDateTime:
              DateTime.parse(map['endDateTime']),
          allDay: map['allDay'],
          reminder: map['reminder'],
          priority: map['priority'],
          colorValue: map['colorValue'],
        ),
      );
    }

    _loaded = true;
  }

  static Future<void> _saveToDisk() async {
    final prefs =
        await SharedPreferences.getInstance();

    final data = _entries.map((entry) {
      return jsonEncode({
        'id': entry.id,
        'type': entry.type,
        'title': entry.title,
        'notes': entry.notes,
        'location': entry.location,
        'meetingLink': entry.meetingLink,
        'startDateTime':
            entry.startDateTime.toIso8601String(),
        'endDateTime':
            entry.endDateTime.toIso8601String(),
        'allDay': entry.allDay,
        'reminder': entry.reminder,
        'priority': entry.priority,
        'colorValue': entry.colorValue,
      });
    }).toList();

    await prefs.setStringList(
      _storageKey,
      data,
    );
  }

  static List<CalendarEntry> get allEntries {
    final copy =
        List<CalendarEntry>.from(_entries);

    copy.sort(
      (a, b) =>
          a.startDateTime.compareTo(
            b.startDateTime,
          ),
    );

    return copy;
  }

  static Future<void> addEntry(
    CalendarEntry entry,
  ) async {
    _entries.add(entry);
    await _saveToDisk();
  }

  static Future<void> deleteEntry(
    String id,
  ) async {
    _entries.removeWhere(
      (entry) => entry.id == id,
    );

    await _saveToDisk();
  }

  static List<CalendarEntry> entriesForDay(
    DateTime date,
  ) {
    final key = dayKey(date);

    final matches = _entries.where((entry) {
      return entry.dayKey == key;
    }).toList();

    matches.sort(
      (a, b) =>
          a.startDateTime.compareTo(
            b.startDateTime,
          ),
    );

    return matches;
  }

  static Set<String> entryDayKeys() {
    return _entries
        .map((entry) => entry.dayKey)
        .toSet();
  }

  static String dayKey(DateTime date) {
    final y =
        date.year.toString().padLeft(4, '0');
    final m =
        date.month.toString().padLeft(2, '0');
    final d =
        date.day.toString().padLeft(2, '0');

    return '$y-$m-$d';
  }
}