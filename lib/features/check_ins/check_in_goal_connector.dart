class CheckInGoalConnector {
  CheckInGoalConnector._();

  static final CheckInGoalConnector instance =
      CheckInGoalConnector._();

  final Map<String, CheckInGoalProgress> _goalProgress = {};

  Map<String, CheckInGoalProgress> get goalProgress =>
      Map.unmodifiable(_goalProgress);

  void updateGoalFromCheckIn({
    required String goalId,
    required String checkInId,
    required String title,
  }) {
    final current = _goalProgress[goalId];

    _goalProgress[goalId] = CheckInGoalProgress(
      goalId: goalId,
      checkInIds: {
        ...?current?.checkInIds,
        checkInId,
      }.toList(),
      lastUpdatedAt: DateTime.now(),
      lastUpdateTitle: title,
    );

    // FUTURE:
    // Connect this to your real GoalsService when ready.
  }

  CheckInGoalProgress? getGoalProgress(String goalId) {
    return _goalProgress[goalId];
  }

  void clear() {
    _goalProgress.clear();
  }
}

class CheckInGoalProgress {
  final String goalId;
  final List<String> checkInIds;
  final DateTime lastUpdatedAt;
  final String lastUpdateTitle;

  const CheckInGoalProgress({
    required this.goalId,
    required this.checkInIds,
    required this.lastUpdatedAt,
    required this.lastUpdateTitle,
  });
}
