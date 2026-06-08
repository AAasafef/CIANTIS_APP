class CalendarEntry {
  final String id;
  final String type;
  final String title;
  final String category;
  final String location;
  final bool locationVerified;
  final String meetingLink;
  final String notes;
  final DateTime startDate;
  final DateTime endDate;
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final bool allDay;
  final String repeat;
  final String alert;
  final String priority;
  final String linkedSpace;
  final String colorName;
  final bool privateEntry;
  final bool addToFamilyCalendar;
  final bool addToTasks;

  const CalendarEntry({
    required this.id,
    required this.type,
    required this.title,
    required this.category,
    required this.location,
    required this.locationVerified,
    required this.meetingLink,
    required this.notes,
    required this.startDate,
    required this.endDate,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.allDay,
    required this.repeat,
    required this.alert,
    required this.priority,
    required this.linkedSpace,
    required this.colorName,
    required this.privateEntry,
    required this.addToFamilyCalendar,
    required this.addToTasks,
  });

  bool occursOn(DateTime date) {
    final cleanDate = DateTime(date.year, date.month, date.day);
    final cleanStart = DateTime(startDate.year, startDate.month, startDate.day);
    final cleanEnd = DateTime(endDate.year, endDate.month, endDate.day);

    return !cleanDate.isBefore(cleanStart) && !cleanDate.isAfter(cleanEnd);
  }

  String get timeLabel {
    if (allDay) return 'All day';
    return '${_formatTime(startHour, startMinute)} - ${_formatTime(endHour, endMinute)}';
  }

  String get startTimeLabel {
    if (allDay) return 'All day';
    return _formatTime(startHour, startMinute);
  }

  String get detailLine {
    final pieces = <String>[];

    if (location.trim().isNotEmpty) {
      pieces.add(location.trim());
    }

    if (meetingLink.trim().isNotEmpty) {
      pieces.add('Meeting link');
    }

    if (notes.trim().isNotEmpty) {
      pieces.add(notes.trim());
    }

    if (pieces.isEmpty) return category;

    return pieces.first;
  }

  static String _formatTime(int hour, int minute) {
    final displayHour = hour == 0 ? 12 : hour > 12 ? hour - 12 : hour;
    final period = hour < 12 ? 'AM' : 'PM';
    final minuteText = minute.toString().padLeft(2, '0');
    return '$displayHour:$minuteText $period';
  }
}
