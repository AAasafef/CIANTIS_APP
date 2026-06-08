class CheckInActivityConnector {
  CheckInActivityConnector._();

  static final CheckInActivityConnector instance =
      CheckInActivityConnector._();

  final List<CheckInActivityEntry> _entries = [];

  List<CheckInActivityEntry> get entries =>
      List.unmodifiable(_entries);

  void logCheckInCompleted({
    required String checkInId,
    required String title,
    required String category,
  }) {
    _entries.insert(
      0,
      CheckInActivityEntry(
        id: 'activity_${DateTime.now().millisecondsSinceEpoch}',
        checkInId: checkInId,
        title: 'Completed $title',
        category: category,
        source: 'Check-Ins',
        createdAt: DateTime.now(),
      ),
    );

    // FUTURE:
    // Connect this to your real ActivityLogService when ready.
  }

  void clear() {
    _entries.clear();
  }
}

class CheckInActivityEntry {
  final String id;
  final String checkInId;
  final String title;
  final String category;
  final String source;
  final DateTime createdAt;

  const CheckInActivityEntry({
    required this.id,
    required this.checkInId,
    required this.title,
    required this.category,
    required this.source,
    required this.createdAt,
  });
}
