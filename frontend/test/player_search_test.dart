import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/team/player_search_page.dart';

void main() {
  testWidgets('PlayerSearchPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PlayerSearchPage()));

    // Verify the presence of widgets on PlayerSearchPage
    expect(find.text('Search Players'), findsOneWidget);
    expect(find.text('Search by player name or city'), findsOneWidget);
    expect(find.text('Filter by City'), findsOneWidget);
  });
}