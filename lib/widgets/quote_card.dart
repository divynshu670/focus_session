
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quote_provider.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuoteProvider>(
      builder: (context, provider, child) {
        return Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.format_quote),
                    SizedBox(width: 8),
                    Text(
                      'DAILY INSPIRATION',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                if (provider.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else ...[
                  Text(
                    '"${provider.quote?.text ?? QuoteProvider.fallbackQuote.text}"',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '— ${provider.quote?.author ?? QuoteProvider.fallbackQuote.author}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (provider.hasError)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Offline or unavailable. Showing a fallback quote.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
