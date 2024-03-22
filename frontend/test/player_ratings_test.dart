import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/profile/player_ratings.dart';
//import 'package:frontend/views/profile/successful_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('PlayerRatingPage Widget Test', (WidgetTester tester) async {
    // Build the PlayerRatingPage widget with necessary providers
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
          child: PlayerRatingPage(
            playerInfo: {
              'user_id': 1,
              'username': 'LeoMessi',
              'age': 25,
              'player_city': 'Barcelona',
              'player_position': 'Forward',
            },
          ),
        ),
      ),
    );
    // Verify that player details are correctly displayed
    expect(find.text('LeoMessi'), findsOneWidget);
    expect(find.text('25'), findsOneWidget);
    expect(find.text('Barcelona'), findsOneWidget);
    expect(find.text('Forward'), findsOneWidget);

    // To Verify the Star Rating is rendered.
    expect(find.byIcon(Icons.star), findsNWidgets(10));

    // Verify that the "Done" button is present
    expect(find.text('Done'), findsOneWidget);

    // Tap the "Done" button
    await tester.scrollUntilVisible(find.text('Done'), 100);
  });
}
