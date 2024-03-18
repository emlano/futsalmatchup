import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/team/team_roster_page.dart';
import 'package:frontend/views/team/player_search_page.dart';
import 'package:frontend/views/team/recommended_players_page.dart';


class MockPlayerSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Mock Player Search Page');
  }
}

class MockRecommendedPlayersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Mock Recommended Players Page');
  }
}

void main() {
  testWidgets('TeamRosterPage UI Test', (WidgetTester tester) async {

    const teamName = 'Test Team';

    await tester.pumpWidget(
      MaterialApp(
        home: TeamRosterPage(teamName: teamName),
        routes: {
          '/player_search_page': (context) => MockPlayerSearchPage(),
          '/recommended_players_page': (context) => MockRecommendedPlayersPage(),
        },
      ),
    );

    expect(find.text(teamName), findsOneWidget);
    expect(find.text('Team Members'), findsOneWidget);
    expect(find.text('+ Search Players'), findsOneWidget);
    expect(find.text('See Players that Match Your Team'), findsOneWidget);
  });
}
