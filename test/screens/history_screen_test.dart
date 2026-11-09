
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:focus_sessions/models/focus_session.dart';
import 'package:focus_sessions/providers/session_provider.dart';
import 'package:focus_sessions/repositories/session_repository.dart';
import 'package:focus_sessions/screens/history_screen.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Displays empty history message', (tester) async {
    final provider = SessionProvider(SessionRepository());

    await provider.loadSessions();

    await tester.pumpWidget(
      ChangeNotifierProvider<SessionProvider>.value(
        value: provider,
        child: const MaterialApp(
          home: HistoryScreen(),
        ),
      ),
    );

    expect(find.text('No focus sessions yet'), findsOneWidget);

    provider.dispose();
  });

  testWidgets('Displays saved session details', (tester) async {
    final repository = SessionRepository();

    final session = FocusSession(
      id: 'test_001',
      startedAt: DateTime(2026, 11, 9, 10),
      endedAt: DateTime(2026, 11, 9, 10, 18),
      plannedDurationMinutes: 25,
      actualDurationSeconds: 1080,
      note: 'Flutter development',
    );

    await repository.saveSessions([session]);

    final provider = SessionProvider(repository);

    await provider.loadSessions();

    await tester.pumpWidget(
      ChangeNotifierProvider<SessionProvider>.value(
        value: provider,
        child: const MaterialApp(
          home: HistoryScreen(),
        ),
      ),
    );

    expect(find.text('Flutter development'), findsOneWidget);
    expect(find.text('25 min'), findsOneWidget);
    expect(find.text('18 min'), findsOneWidget);

    provider.dispose();
  });
}
