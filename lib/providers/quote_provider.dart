
import 'package:flutter/foundation.dart';

import '../repositories/quote_repository.dart';

class QuoteProvider extends ChangeNotifier {
  final QuoteRepository _repository;

  QuoteProvider(this._repository);

  Quote? _quote;
  Quote? get quote => _quote;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  static const Quote fallbackQuote = Quote(
    text: 'Great things are done by a series of small things brought together.',
    author: 'Vincent van Gogh',
  );

  Future<void> loadQuote() async {
    if (_isLoading || _quote != null) return;

    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _quote = await _repository.fetchQuote();
    } catch (_) {
      _quote = fallbackQuote;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
