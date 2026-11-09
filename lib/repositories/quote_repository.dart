
import 'dart:convert';

import 'package:http/http.dart' as http;

class Quote {
  final String text;
  final String author;

  const Quote({
    required this.text,
    required this.author,
  });
}

class QuoteRepository {
  Future<Quote> fetchQuote() async {
    final response = await http
        .get(
          Uri.parse('https://zenquotes.io/api/random'),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Unable to fetch quote');
    }

    final List<dynamic> data = jsonDecode(response.body);

    if (data.isEmpty) {
      throw Exception('Empty quote response');
    }

    return Quote(
      text: data[0]['q'] as String,
      author: data[0]['a'] as String,
    );
  }
}
