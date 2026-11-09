
class FocusSession {
  final String id;
  final DateTime startedAt;
  final DateTime endedAt;
  final int plannedDurationMinutes;
  final int actualDurationSeconds;
  final String note;

  const FocusSession({
    required this.id,
    required this.startedAt,
    required this.endedAt,
    required this.plannedDurationMinutes,
    required this.actualDurationSeconds,
    required this.note,
  });

  int get actualDurationMinutes => actualDurationSeconds ~/ 60;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startedAt': startedAt.toIso8601String(),
      'endedAt': endedAt.toIso8601String(),
      'plannedDurationMinutes': plannedDurationMinutes,
      'actualDurationSeconds': actualDurationSeconds,
      'note': note,
    };
  }

  factory FocusSession.fromJson(Map<String, dynamic> json) {
    return FocusSession(
      id: json['id'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: DateTime.parse(json['endedAt'] as String),
      plannedDurationMinutes: json['plannedDurationMinutes'] as int,
      actualDurationSeconds: json['actualDurationSeconds'] as int,
      note: json['note'] as String,
    );
  }
}
