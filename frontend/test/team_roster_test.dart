import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/team/team_roster_page.dart';
import 'package:frontend/views/team/player_search_page.dart';
import 'package:frontend/views/team/recommended_players_page.dart';

// Mock implementation of PlayerSearchPage widget
class MockPlayerSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Mock Player Search Page');
  }
}

// Mock implementation of RecommendedPlayersPage widget
class MockRecommendedPlayersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Mock Recommended Players Page');
  }
}

void main() {
  testWidgets('TeamRosterPage UI Test', (WidgetTester tester) async {

    const teamName = 'Test Team';

    // Call the TeamRosterPage widget with MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: TeamRosterPage(teamName: teamName),
        routes: {
          '/player_search_page': (context) => MockPlayerSearchPage(),
          '/recommended_players_page': (context) => MockRecommendedPlayersPage(),
        },
      ),
    );

    expect(find.text(teamName), findsOneWidget); // Verify the team name
    expect(find.text('Team Members'), findsOneWidget); // Checks if 'Team Members' text is present
    expect(find.text('+ Search Players'), findsOneWidget); // Checks if '+ Search Players' text is present
    expect(find.text('See Players that Match Your Team'), findsOneWidget); // Checks if 'See Players that Match Your Team' text is there
  });
}
