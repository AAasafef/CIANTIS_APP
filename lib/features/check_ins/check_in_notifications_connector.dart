class CheckInNotificationsConnector {
  CheckInNotificationsConnector._();

  static final CheckInNotificationsConnector instance =
      CheckInNotificationsConnector._();

  final List<CheckInReminderEntry> _reminders = [];

  List<CheckInReminderEntry> get reminders =>
      List.unmodifiable(_reminders);

  void createMissedReminder({
    required String checkInId,
    required String title,
    required String frequency,
  }) {
    _reminders.insert(
      0,
      CheckInReminderEntry(
        id: 'reminder_${DateTime.now().millisecondsSinceEpoch}',
        checkInId: checkInId,
        title: title,
        message: '$title is still waiting for your $frequency check-in.',
        createdAt: DateTime.now(),
      ),
    );

    // FUTURE:
    // Connect this to your real NotificationService / ReminderService.
  }

  void removeReminderForCheckIn(String checkInId) {
    _reminders.removeWhere(
      (item) => item.checkInId == checkInId,
    );
  }

  void clear() {
    _reminders.clear();
  }
}

class CheckInReminderEntry {
  final String id;
  final String checkInId;
  final String title;
  final String message;
  final DateTime createdAt;

  const CheckInReminderEntry({
    required this.id,
    required this.checkInId,
    required this.title,
    required this.message,
    required this.createdAt,
  });
}
