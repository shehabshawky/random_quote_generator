import 'package:flutter_test/flutter_test.dart';
import 'package:quote_app/data/quote_repository.dart';

void main() {
  group('QuoteRepository Tests', () {
    test('getRandomQuote returns a valid quote on initial call', () {
      final quote = QuoteRepository.getRandomQuote();
      expect(quote.text.isNotEmpty, isTrue);
      expect(quote.author.isNotEmpty, isTrue);
      expect(quote.category.isNotEmpty, isTrue);
    });

    test('getRandomQuote with currentQuote returns a different quote', () {
      final first = QuoteRepository.getRandomQuote();
      final second = QuoteRepository.getRandomQuote(currentQuote: first);
      expect(second.id, isNot(equals(first.id)));
    });

    test('getRandomQuote by category returns quote of that category', () {
      const category = 'Wisdom';
      final quote = QuoteRepository.getRandomQuote(category: category);
      expect(quote.category.toLowerCase(), equals(category.toLowerCase()));
    });
  });
}
