class CheckInSpaceConnector {
  CheckInSpaceConnector._();

  static final CheckInSpaceConnector instance =
      CheckInSpaceConnector._();

  final Map<String, List<String>> _spaceUpdates = {
    'dashboard': [],
    'beauty': [],
    'wellness': [],
    'goals': [],
  };

  Map<String, List<String>> get spaceUpdates =>
      Map.unmodifiable(_spaceUpdates);

  void syncToSpaces({
    required String checkInId,
    required bool dashboard,
    required bool beauty,
    required bool wellness,
    required bool goals,
  }) {
    if (dashboard) {
      _addToSpace('dashboard', checkInId);
    }

    if (beauty) {
      _addToSpace('beauty', checkInId);
    }

    if (wellness) {
      _addToSpace('wellness', checkInId);
    }

    if (goals) {
      _addToSpace('goals', checkInId);
    }

    // FUTURE:
    // Each space should read from CheckInService instead of duplicating data.
  }

  List<String> checkInsForSpace(String spaceKey) {
    return List.unmodifiable(_spaceUpdates[spaceKey] ?? []);
  }

  void _addToSpace(String spaceKey, String checkInId) {
    final list = _spaceUpdates.putIfAbsent(spaceKey, () => []);

    if (!list.contains(checkInId)) {
      list.add(checkInId);
    }
  }

  void clear() {
    for (final key in _spaceUpdates.keys) {
      _spaceUpdates[key] = [];
    }
  }
}
