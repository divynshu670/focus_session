
import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/focus_session.dart';
import '../repositories/session_repository.dart';

class SessionProvider extends ChangeNotifier {
  final SessionRepository _repository;

  SessionProvider(this._repository);

  List<FocusSession> _sessions = [];

  List<FocusSession> get sessions => List.unmodifiable(_sessions);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DateTime? _startedAt;
  DateTime? get startedAt => _startedAt;

  DateTime? _endedAt;

  int _plannedDurationMinutes = 25;
  int get plannedDurationMinutes => _plannedDurationMinutes;

  int _actualDurationSeconds = 0;
  int get actualDurationSeconds => _actualDurationSeconds;

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  bool _isAwaitingNote = false;
  bool get isAwaitingNote => _isAwaitingNote;

  Timer? _timer;

  int get elapsedSeconds {
    if (_startedAt == null) return 0;

    if (_endedAt != null) {
      return _actualDurationSeconds;
    }

    final elapsed = DateTime.now().difference(_startedAt!).inSeconds;

    return elapsed.clamp(0, _plannedDurationMinutes * 60);
  }

  int get remainingSeconds {
    final remaining = (_plannedDurationMinutes * 60) - elapsedSeconds;
    return remaining.clamp(0, _plannedDurationMinutes * 60);
  }

  Future<void> loadSessions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _sessions = await _repository.getSessions();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void startSession(int durationMinutes) {
    if (_isRunning || _isAwaitingNote) return;

    _plannedDurationMinutes = durationMinutes;
    _startedAt = DateTime.now();
    _endedAt = null;
    _actualDurationSeconds = 0;
    _isRunning = true;
    _isAwaitingNote = false;

    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (remainingSeconds <= 0) {
          _finishTimer();
        } else {
          notifyListeners();
        }
      },
    );

    notifyListeners();
  }

  void stopSession() {
    if (!_isRunning) return;

    _finishTimer();
  }

  
void _finishTimer() {
  if (!_isRunning) return;

  _actualDurationSeconds = elapsedSeconds;
  _endedAt = DateTime.now();

  _isRunning = false;
  _isAwaitingNote = true;

  _timer?.cancel();
  _timer = null;

  notifyListeners();
}


  Future<void> saveActiveSession(String note) async {
    if (!_isAwaitingNote || _startedAt == null || _endedAt == null) {
      return;
    }

    final session = FocusSession(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      startedAt: _startedAt!,
      endedAt: _endedAt!,
      plannedDurationMinutes: _plannedDurationMinutes,
      actualDurationSeconds: _actualDurationSeconds,
      note: note.trim(),
    );

    await _repository.saveSessions([
      session,
      ..._sessions,
    ]);

    _sessions = await _repository.getSessions();

    _resetSession();

    notifyListeners();
  }

  void cancelActiveSession() {
    _timer?.cancel();
    _resetSession();
    notifyListeners();
  }

  void _resetSession() {
    _startedAt = null;
    _endedAt = null;
    _actualDurationSeconds = 0;
    _isRunning = false;
    _isAwaitingNote = false;
  }

  Future<void> deleteSession(String id) async {
    await _repository.deleteSession(id);

    _sessions = _sessions.where((s) => s.id != id).toList();

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
