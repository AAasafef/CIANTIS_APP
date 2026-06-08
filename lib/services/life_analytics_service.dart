import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/life_analytics_entry.dart';
import '../models/life_milestone_entry.dart';

class LifeAnalyticsService {
  static const String _entriesKey = 'ciantis_life_analytics_entries';
  static const String _milestonesKey = 'ciantis_life_milestone_entries';

  static Future<List<LifeAnalyticsEntry>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_entriesKey) ?? [];

    final entries = raw
        .map((item) {
          try {
            return LifeAnalyticsEntry.fromJson(jsonDecode(item));
          } catch (_) {
            return null;
          }
        })
        .whereType<LifeAnalyticsEntry>()
        .toList();

    entries.sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }

  static Future<void> saveEntry(LifeAnalyticsEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await getEntries();

    entries.removeWhere((item) => item.id == entry.id);
    entries.add(entry);
    entries.sort((a, b) => a.date.compareTo(b.date));

    await prefs.setStringList(
      _entriesKey,
      entries.map((item) => jsonEncode(item.toJson())).toList(),
    );
  }

  static Future<void> logJournalEntry({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
  }) async {
    await saveEntry(
      LifeAnalyticsEntry(
        id: 'journal_$id',
        date: createdAt,
        source: 'Journal',
        type: 'journal',
        value: 1,
        label: title,
        note: content,
      ),
    );
  }

  static Future<void> logMood({
    required int moodScore,
    required String moodLabel,
    String? note,
    DateTime? date,
  }) async {
    final now = date ?? DateTime.now();

    await saveEntry(
      LifeAnalyticsEntry(
        id: 'mood_${now.microsecondsSinceEpoch}',
        date: now,
        source: 'Check-In',
        type: 'mood',
        value: moodScore.toDouble(),
        label: moodLabel,
        note: note,
      ),
    );
  }

  static Future<void> logPeriodSymptom({
    required String symptom,
    required int severity,
    String? note,
    DateTime? date,
  }) async {
    final now = date ?? DateTime.now();

    await saveEntry(
      LifeAnalyticsEntry(
        id: 'period_${now.microsecondsSinceEpoch}',
        date: now,
        source: 'Cycle',
        type: 'period_symptom',
        value: severity.toDouble(),
        label: symptom,
        note: note,
      ),
    );
  }

  static Future<void> logCustom({
    required String source,
    required String type,
    required String label,
    required double value,
    String? note,
    DateTime? date,
    Map<String, dynamic> extra = const {},
  }) async {
    final now = date ?? DateTime.now();

    await saveEntry(
      LifeAnalyticsEntry(
        id: '${type}_${now.microsecondsSinceEpoch}',
        date: now,
        source: source,
        type: type,
        value: value,
        label: label,
        note: note,
        extra: extra,
      ),
    );
  }

  static Future<List<LifeMilestoneEntry>> getMilestones() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_milestonesKey) ?? [];

    final milestones = raw
        .map((item) {
          try {
            return LifeMilestoneEntry.fromJson(jsonDecode(item));
          } catch (_) {
            return null;
          }
        })
        .whereType<LifeMilestoneEntry>()
        .toList();

    milestones.sort((a, b) => a.date.compareTo(b.date));
    return milestones;
  }

  static Future<void> saveMilestone(LifeMilestoneEntry milestone) async {
    final prefs = await SharedPreferences.getInstance();
    final milestones = await getMilestones();

    milestones.removeWhere((item) => item.id == milestone.id);
    milestones.add(milestone);
    milestones.sort((a, b) => a.date.compareTo(b.date));

    await prefs.setStringList(
      _milestonesKey,
      milestones.map((item) => jsonEncode(item.toJson())).toList(),
    );
  }
}