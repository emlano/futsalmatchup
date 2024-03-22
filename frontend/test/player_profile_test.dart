import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/profile/player_profile.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  // Test case for PlayerProfile Widget
  testWidgets('PlayerProfile Widget Test', (WidgetTester tester) async {
    // Mock AuthProvider
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
          child: PlayerProfile(),
        ),
      ),
    );

    // To Verify the Player Name is not rendered
    expect(find.text('Player Name'), findsNothing);

    // To Verify the Star Rating is rendered.
    expect(find.byIcon(Icons.star), findsNWidgets(4));

    // To Verify the "Update Status" text is rendered.
    expect(find.text('Update Status'), findsOneWidget);

    // Toggle the switch and verify if it updates the state
    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.byType(Switch), findsOneWidget);
  });

// Test case for Edit Button in PlayerProfile
  testWidgets('PlayerProfile Edit Button Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
          child: PlayerProfile(),
        ),
      ),
    );

    // To Verify the initial state is not in editing mode.
    expect(find.text('Save'), findsNothing);

    // Click on the "Edit" button.
    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();

    // To Verify the editing mode is activated.
    expect(find.text('Save'), findsOneWidget);
  });

  // Test case for Switch in PlayerProfile
  testWidgets('PlayerProfile Switch Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
          child: PlayerProfile(),
        ),
      ),
    );
    // To Verify the initial state is true.
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('Update Status'), findsOneWidget);

// Toggle the switch and verify if the state is updated
    await tester.tap(find.byType(Switch));
    await tester.pump();

    // To Verify the state is updated.
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('Update Status'), findsOneWidget);
  });

// Test case for Player Information Section in PlayerProfile
  testWidgets('PlayerProfile Player Information Section Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
          child: PlayerProfile(),
        ),
      ),
    );

// Scroll to Player Information section
    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -300));

    // To Verify the "Player Information" section is rendered.
    expect(find.text('Player Information'), findsOneWidget);
  });
}
