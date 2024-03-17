import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/home/Home.dart';

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

    // Close the drawer by tapping outside the drawer.
    await tester.tapAt(Offset(300, 300));
    await tester.pumpAndSettle();

    // Verify that the menu is closed.
    expect(find.text('User Profile'), findsNothing);
    expect(find.text('Book a Stadium'), findsNothing);
    expect(find.text('Create a Team'), findsNothing);
  });
}
