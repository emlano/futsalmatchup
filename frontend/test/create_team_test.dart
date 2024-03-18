import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/views/team/create_team_page.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('CreateTeamPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        child: CreateTeamPage(),
      ),
    ));

    // Verify the presence of widgets on CreateTeamPage
    expect(find.text('Create Your Team'), findsOneWidget);
    expect(find.text('Enter your Team Name'), findsOneWidget);
    expect(find.text('Create Team'), findsOneWidget);

    // Simulate entering text into the team name TextField
    await tester.enterText(find.byType(TextField), 'Test Team');

    // Tap the create team button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Expect snackbar for authentication token not available since token is null in AuthProvider
    expect(find.text('Authentication token not available.'), findsOneWidget);
  });
}
