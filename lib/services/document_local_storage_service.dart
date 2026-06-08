import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DocumentLocalStorageService {
  static const String documentsKey =
      'ciantis_documents';

  static Future<void> saveDocuments(
    List<Map<String, dynamic>> documents,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    final encoded =
        jsonEncode(documents);

    await prefs.setString(
      documentsKey,
      encoded,
    );
  }

  static Future<List<Map<String, dynamic>>>
      loadDocuments() async {
    final prefs =
        await SharedPreferences.getInstance();

    final data =
        prefs.getString(documentsKey);

    if (data == null) {
      return [];
    }

    final decoded =
        jsonDecode(data) as List;

    return decoded
        .map(
          (e) =>
              Map<String, dynamic>.from(
            e,
          ),
        )
        .toList();
  }

  static Future<void> clearDocuments()
      async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      documentsKey,
    );
  }
}