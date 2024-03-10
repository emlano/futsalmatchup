import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/home/Home.dart';
import 'package:frontend/views/profile//player_profile.dart';
import 'package:frontend/views/stadium/stadium_availability_page.dart';
import 'package:frontend/views/team/create_team_page.dart';

void main() {
  testWidgets('Homepage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Home()));

    // Verify the presence of widgets on HomePage

    // Verify that the title is rendered.
    expect(find.text("Futsal MatchUp"), findsOneWidget);

    // Open the drawer by tapping the hamburger icon.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the menu items are present.
    expect(find.text('User Profile'), findsOneWidget);
    expect(find.text('Book a Stadium'), findsOneWidget);
    expect(find.text('Create a Team'), findsOneWidget);

    // Test tapping on the 'User Profile' menu item.
    await tester.tap(find.text('User Profile'));
    await tester.pumpAndSettle();
    expect(find.byType(PlayerProfile), findsOneWidget);

    // Test tapping on the 'Book a Stadium' menu item.
    await tester.tap(find.text('Book a Stadium'));
    await tester.pumpAndSettle();
    expect(find.byType(StadiumPage), findsOneWidget);

    // Test tapping on the 'Create a Team' menu item.
    await tester.tap(find.text('Create a Team'));
    await tester.pumpAndSettle();
    expect(find.byType(CreateTeamPage), findsOneWidget);

    // Close the drawer by tapping outside the drawer.
    await tester.tapAt(Offset(0, 0));
    await tester.pumpAndSettle();

    // Verify that the menu is closed.
    expect(find.text('User Profile'), findsNothing);
    expect(find.text('Book a Stadium'), findsNothing);
    expect(find.text('Create a Team'), findsNothing);

    // Example: Check if the "UPCOMING BOOKINGS" text is present.
    expect(find.text('UPCOMING BOOKINGS'), findsOneWidget);

    // Example: Check if the first booking template is present.
    expect(find.text("Unique Warriors vs Spacers"), findsOneWidget);
    expect(find.text("CRFC kalubowila"), findsOneWidget);
    expect(find.text("8.00-9.00"), findsOneWidget);

    // Example: Check if the Teams template is present.
    expect(find.text('TEAMS'), findsOneWidget);

    // Example: Check if the first INVITES template is present.
    expect(find.text('INVITES'), findsOneWidget);
    expect(find.text('menu to lead to other pages'), findsOneWidget);
  });
}
