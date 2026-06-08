class LifeAnalyticsEntry {
  final String id;
  final DateTime date;
  final String source;
  final String type;
  final double value;
  final String label;
  final String? note;
  final Map<String, dynamic> extra;

  const LifeAnalyticsEntry({
    required this.id,
    required this.date,
    required this.source,
    required this.type,
    required this.value,
    required this.label,
    this.note,
    this.extra = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'source': source,
      'type': type,
      'value': value,
      'label': label,
      'note': note,
      'extra': extra,
    };
  }

  factory LifeAnalyticsEntry.fromJson(Map<String, dynamic> json) {
    return LifeAnalyticsEntry(
      id: json['id']?.toString() ?? '',
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
      source: json['source']?.toString() ?? 'unknown',
      type: json['type']?.toString() ?? 'unknown',
      value: json['value'] is num ? (json['value'] as num).toDouble() : 0,
      label: json['label']?.toString() ?? '',
      note: json['note']?.toString(),
      extra: Map<String, dynamic>.from(json['extra'] ?? {}),
    );
  }
}