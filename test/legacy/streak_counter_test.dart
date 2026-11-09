
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_sessions/legacy/streak_counter.dart';

void main() {
  group('StreakCounter tests', () {
    final today = DateTime.now();

    DateTime day(int daysAgo, {int hour = 12}) {
      final date = today.subtract(Duration(days: daysAgo));

      return DateTime(
        date.year,
        date.month,
        date.day,
        hour,
      );
    }

    test('Counts consecutive days ending today', () {
      final counter = StreakCounter([
        day(0),
        day(1),
        day(2),
      ]);

      expect(counter.currentStreak(), 3);
    });

    test('Duplicate sessions on same day count once', () {
      final counter = StreakCounter([
        day(0, hour: 8),
        day(0, hour: 12),
        day(0, hour: 18),
        day(1),
      ]);

      expect(counter.currentStreak(), 2);
    });

    test('Returns zero when there is no session today', () {
      final counter = StreakCounter([
        day(1),
        day(2),
        day(3),
      ]);

      expect(counter.currentStreak(), 0);
    });

    test('Ignores time of day when comparing calendar dates', () {
      final counter = StreakCounter([
        day(0, hour: 0),
        day(1, hour: 23),
      ]);

      expect(counter.currentStreak(), 2);
    });

    test('Stops counting when a day is missing', () {
      final counter = StreakCounter([
        day(0),
        day(1),
        day(3),
        day(4),
      ]);

      expect(counter.currentStreak(), 2);
    });
  });
}
