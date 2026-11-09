
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/focus_session.dart';

class SessionRepository {
  static const String _storageKey = 'focus_sessions';

  Future<List<FocusSession>> getSessions() async {
    final preferences = await SharedPreferences.getInstance();

    final storedData = preferences.getString(_storageKey);

    if (storedData == null || storedData.isEmpty) {
      return [];
    }

    final List<dynamic> decodedData = jsonDecode(storedData);

    final sessions = decodedData.map((item) {
      return FocusSession.fromJson(
        Map<String, dynamic>.from(item as Map),
      );
    }).toList();

    sessions.sort(
      (a, b) => b.startedAt.compareTo(a.startedAt),
    );

    return sessions;
  }

  Future<void> saveSessions(List<FocusSession> sessions) async {
    final preferences = await SharedPreferences.getInstance();

    final encodedData = jsonEncode(
      sessions.map((session) => session.toJson()).toList(),
    );

    await preferences.setString(_storageKey, encodedData);
  }

  Future<void> deleteSession(String id) async {
    final sessions = await getSessions();

    sessions.removeWhere((session) => session.id == id);

    await saveSessions(sessions);
  }
}
