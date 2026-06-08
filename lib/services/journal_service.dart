import '../models/journal_entry_model.dart';
import 'life_analytics_service.dart';

class JournalService {
  static final JournalService instance = JournalService._internal();

  JournalService._internal();

  final List<JournalEntryModel> _entries = [];

  List<JournalEntryModel> getEntries() {
    return List.unmodifiable(_entries);
  }

  Future<void> addEntry(JournalEntryModel entry) async {
    final existingIndex = _entries.indexWhere((item) => item.id == entry.id);

    if (existingIndex == -1) {
      _entries.insert(0, entry);
    } else {
      _entries[existingIndex] = entry;
    }

    LifeAnalyticsService.logJournalEntry(
      id: entry.id,
      title: entry.title,
      content: entry.content,
      createdAt: entry.createdAt,
    );
  }

  Future<void> updateEntry(JournalEntryModel updatedEntry) async {
    final index = _entries.indexWhere((entry) => entry.id == updatedEntry.id);

    if (index == -1) {
      _entries.insert(0, updatedEntry);
      return;
    }

    _entries[index] = updatedEntry;
  }

  Future<void> deleteEntry(String id) async {
    _entries.removeWhere((entry) => entry.id == id);
  }
}