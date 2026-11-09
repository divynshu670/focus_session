
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_sessions/models/focus_session.dart';

void main() {
  group('FocusSession tests', () {
    final session = FocusSession(
      id: 'test_001',
      startedAt: DateTime(2026, 11, 9, 10, 0),
      endedAt: DateTime(2026, 11, 9, 10, 18),
      plannedDurationMinutes: 25,
      actualDurationSeconds: 1080,
      note: 'Flutter development',
    );

    test('Calculates actual duration in minutes', () {
      expect(session.actualDurationMinutes, 18);
    });

    test('Converts session to JSON and back', () {
      final json = session.toJson();

      final restoredSession = FocusSession.fromJson(json);

      expect(restoredSession.id, session.id);
      expect(restoredSession.plannedDurationMinutes, 25);
      expect(restoredSession.actualDurationSeconds, 1080);
      expect(restoredSession.note, 'Flutter development');
      expect(restoredSession.startedAt, session.startedAt);
      expect(restoredSession.endedAt, session.endedAt);
    });
  });
}
