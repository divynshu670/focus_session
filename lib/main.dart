
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/session_provider.dart';
import 'providers/quote_provider.dart';
import 'repositories/session_repository.dart';
import 'repositories/quote_repository.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const FocusSessionsApp());
}

class FocusSessionsApp extends StatelessWidget {
  const FocusSessionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SessionProvider(SessionRepository())
            ..loadSessions(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuoteProvider(QuoteRepository())
            ..loadQuote(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Focus Sessions',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
          ),
          scaffoldBackgroundColor: const Color(0xFFF7F6FA),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
