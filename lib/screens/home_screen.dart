
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/session_provider.dart';
import '../widgets/focus_timer.dart';
import '../widgets/quote_card.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedDuration = 25;
  bool _dialogOpen = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<SessionProvider>().addListener(
        _handleSessionChange,
      );
    });
  }

  void _handleSessionChange() {
    if (!mounted || _dialogOpen) return;

    final provider = context.read<SessionProvider>();

    if (provider.isAwaitingNote) {
      _showCompletionDialog();
    }
  }

  Future<void> _showCompletionDialog() async {
    _dialogOpen = true;

    final controller = TextEditingController();

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Focus session completed!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('What did you work on?'),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                autofocus: true,
                maxLength: 120,
                decoration: const InputDecoration(
                  hintText: 'e.g. Flutter development',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<SessionProvider>().cancelActiveSession();
                Navigator.pop(dialogContext);
              },
              child: const Text('Discard'),
            ),
            FilledButton(
              onPressed: () async {
                await context
                    .read<SessionProvider>()
                    .saveActiveSession(controller.text);

                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Save session'),
            ),
          ],
        );
      },
    );

    controller.dispose();
    _dialogOpen = false;
  }

  @override
  void dispose() {
    context.read<SessionProvider>().removeListener(
      _handleSessionChange,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Focus Sessions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Session history',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HistoryScreen(),
                ),
              );
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Consumer<SessionProvider>(
        builder: (context, provider, child) {
          final busy = provider.isRunning || provider.isAwaitingNote;

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Make time for what matters.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'One session at a time. One step at a time.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 24),

                const QuoteCard(),

                const SizedBox(height: 28),

                const Center(
                  child: Text(
                    'CHOOSE YOUR DURATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [15, 25, 45].map((minutes) {
                    final selected = selectedDuration == minutes;

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ChoiceChip(
                          label: Text('$minutes min'),
                          selected: selected,
                          onSelected: busy
                              ? null
                              : (_) {
                                  setState(() {
                                    selectedDuration = minutes;
                                  });
                                },
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 28),

                const Center(
                  child: FocusTimer(),
                ),

                const SizedBox(height: 28),

                if (!provider.isRunning && !provider.isAwaitingNote)
                  FilledButton.icon(
                    onPressed: () {
                      provider.startSession(selectedDuration);
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Focus Session'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(17),
                    ),
                  ),

                if (provider.isRunning)
                  FilledButton.icon(
                    onPressed: provider.stopSession,
                    icon: const Icon(Icons.stop),
                    label: const Text('End Session Early'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                      padding: const EdgeInsets.all(17),
                    ),
                  ),

                if (provider.isAwaitingNote)
                  const Center(
                    child: Text('Please save or discard your session.'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
