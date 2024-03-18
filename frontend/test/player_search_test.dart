import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/team/player_search_page.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/auth_provider.dart'; // Import your provider

void main() {
  testWidgets('PlayerSearchPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
          child: PlayerSearchPage(),
        ),
      ),
    );

    // Verify the presence of widgets on PlayerSearchPage
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
  });
}
