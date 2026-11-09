
import 'package:flutter/material.dart';

import '../models/focus_session.dart';

class SessionCard extends StatelessWidget {
  final FocusSession session;

  const SessionCard({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    final date = session.startedAt;

    final formattedDate =
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.center_focus_strong, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    session.note.isEmpty
                        ? 'Focus session'
                        : session.note,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              formattedDate,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DurationInfo(
                    label: 'Planned',
                    value: '${session.plannedDurationMinutes} min',
                  ),
                ),
                Expanded(
                  child: _DurationInfo(
                    label: 'Actual',
                    value: '${session.actualDurationMinutes} min',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DurationInfo extends StatelessWidget {
  final String label;
  final String value;

  const _DurationInfo({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
