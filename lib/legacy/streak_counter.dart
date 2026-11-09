
class StreakCounter {
  final List<DateTime> sessionDays;

  StreakCounter(this.sessionDays);

  /// Returns consecutive calendar days ending today.
  int currentStreak() {
    if (sessionDays.isEmpty) return 0;

    final today = DateTime.now();

    final todayDate = DateTime(
      today.year,
      today.month,
      today.day,
    );

    final uniqueDays = <DateTime>{};

    for (final sessionDay in sessionDays) {
      uniqueDays.add(
        DateTime(
          sessionDay.year,
          sessionDay.month,
          sessionDay.day,
        ),
      );
    }

    if (!uniqueDays.contains(todayDate)) {
      return 0;
    }

    var streak = 0;
    var cursor = todayDate;

    while (uniqueDays.contains(cursor)) {
      streak++;

      cursor = cursor.subtract(
        const Duration(days: 1),
      );
    }

    return streak;
  }
}
