import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/life_analytics_entry.dart';
import '../models/life_milestone_entry.dart';

class LifeAnalyticsService {
  static const String _analyticsKey = 'ciantis_life_analytics_entries';
  static const String _milestonesKey = 'ciantis_life_milestone_entries';

  static Future<List<LifeAnalyticsEntry>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_analyticsKey) ?? [];

    return raw
        .map((item) => LifeAnalyticsEntry.fromJson(jsonDecode(item)))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  static Future<void> saveEntry(LifeAnalyticsEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await getEntries();

    entries.removeWhere((e) => e.id == entry.id);
    entries.add(entry);

    await prefs.setStringList(
      _analyticsKey,
      entries.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  static Future<void> logMood({
    required int moodScore,
    required String moodLabel,
    String? note,
    String source = 'check_in',
  }) async {
    await saveEntry(
      LifeAnalyticsEntry(
        id: 'mood_${DateTime.now().millisecondsSinceEpoch}',
        date: DateTime.now(),
        source: source,
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
  }) async {
    await saveEntry(
      LifeAnalyticsEntry(
        id: 'period_${DateTime.now().millisecondsSinceEpoch}',
        date: DateTime.now(),
        source: 'period',
        type: 'period_symptom',
        value: severity.toDouble(),
        label: symptom,
        note: note,
      ),
    );
  }

  static Future<void> logJournalEntry({
    required String title,
    String? note,
    double value = 1,
  }) async {
    await saveEntry(
      LifeAnalyticsEntry(
        id: 'journal_${DateTime.now().millisecondsSinceEpoch}',
        date: DateTime.now(),
        source: 'journal',
        type: 'journal',
        value: value,
        label: title,
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
  }) async {
    await saveEntry(
      LifeAnalyticsEntry(
        id: '${type}_${DateTime.now().millisecondsSinceEpoch}',
        date: DateTime.now(),
        source: source,
        type: type,
        value: value,
        label: label,
        note: note,
      ),
    );
  }

  static Future<List<LifeMilestoneEntry>> getMilestones() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_milestonesKey) ?? [];

    return raw
        .map((item) => LifeMilestoneEntry.fromJson(jsonDecode(item)))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  static Future<void> saveMilestone(LifeMilestoneEntry milestone) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getMilestones();

    items.removeWhere((e) => e.id == milestone.id);
    items.add(milestone);

    await prefs.setStringList(
      _milestonesKey,
      items.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}