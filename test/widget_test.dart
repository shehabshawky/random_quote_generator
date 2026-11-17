import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quote_app/main.dart';
import 'package:quote_app/widgets/quote_card.dart';

void main() {
  testWidgets('Random Quote Generator smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuoteApp());
    await tester.pumpAndSettle();

    // Verify header title and button exist
    expect(find.text('Daily Quotes'), findsOneWidget);
    expect(find.text('New Quote'), findsOneWidget);

    // Verify QuoteCard is rendered
    expect(find.byType(QuoteCard), findsOneWidget);

    // Verify New Quote button tap updates state
    final newQuoteButton = find.byKey(const Key('new_quote_button'));
    expect(newQuoteButton, findsOneWidget);

    await tester.tap(newQuoteButton);
    await tester.pumpAndSettle();

    // Verify counter shows 2 quotes explored
    expect(find.text('2 quotes explored this session'), findsOneWidget);
  });
}
