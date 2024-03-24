import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/views/team/create_team_page.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('CreateTeamPage UI Test', (WidgetTester tester) async {
    // Call the CreateTeamPage widget wrapped with ChangeNotifierProvider for AuthProvider
    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(), // Create a new instance of AuthProvider
        child: CreateTeamPage(), // Call the CreateTeamPage widget
      ),
    ));

    // Verify the presence of widgets on CreateTeamPage
    expect(find.text('Create Your Team'), findsOneWidget); // Checks for 'Create Your Team' text
    expect(find.text('Enter your Team Name'), findsOneWidget); // Checks for 'Enter your Team Name' text
    expect(find.text('Create Team'), findsOneWidget); // Checks for 'Create Team' text

    // Simulate entering text into the team name TextField
    await tester.enterText(find.byType(TextField), 'Test Team'); // Enter 'Test Team' into the TextField

    // Tap the create team button
    await tester.tap(find.byType(ElevatedButton)); // Tap on ElevatedButton
    await tester.pump(); // Rebuild the widget after tapping

    // Expect snackbar for authentication token not available since token is null in AuthProvider
    expect(find.text('Authentication token not available.'), findsOneWidget); // Checks if the snackbar is present
  });
}
