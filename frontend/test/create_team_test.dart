import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/team/create_team_page.dart';

void main() {
  testWidgets('CreateTeamPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CreateTeamPage()));

    // Verify the presence of widgets on CreateTeamPage
    expect(find.text('Create Your Team'), findsOneWidget);
    expect(find.text('Enter your Team Name'), findsOneWidget);
    expect(find.text('Create Team'), findsOneWidget);
  });
}