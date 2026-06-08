import 'dart:convert';

import 'package:flutter/services.dart';

class DailyDevotional {
  final int day;
  final String reference;
  final String verse;
  final String reflection;
  final String prayer;
  final String category;

  const DailyDevotional({
    required this.day,
    required this.reference,
    required this.verse,
    required this.reflection,
    required this.prayer,
    required this.category,
  });

  factory DailyDevotional.fromJson(
    Map<String, dynamic> json,
  ) {
    return DailyDevotional(
      day: json['day'] ?? 1,
      reference: json['reference'] ?? '',
      verse: json['verse'] ?? '',
      reflection: json['reflection'] ?? '',
      prayer: json['prayer'] ?? '',
      category: json['category'] ?? '',
    );
  }
}

class DailyDevotionalService {
  static Future<List<DailyDevotional>>
      loadDevotionals() async {
    final String response =
        await rootBundle.loadString(
      'assets/data/daily_verses.json',
    );

    final List<dynamic> data =
        json.decode(response);

    return data
        .map(
          (item) => DailyDevotional.fromJson(
            item,
          ),
        )
        .toList();
  }

  static int getDayOfYear() {
    final now = DateTime.now();

    final startOfYear = DateTime(
      now.year,
      1,
      1,
    );

    return now
            .difference(startOfYear)
            .inDays +
        1;
  }

  static Future<DailyDevotional>
      getTodayDevotional() async {
    final devotionals =
        await loadDevotionals();

    final dayOfYear = getDayOfYear();

    final index =
        (dayOfYear - 1) %
            devotionals.length;

    return devotionals[index];
  }
}