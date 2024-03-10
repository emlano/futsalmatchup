import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/home/Home.dart';

void main() {
  testWidgets('Homepage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Home()));

    // Verify the presence of widgets on CreateTeamPage
    expect(find.text('Upcoming Bookings'), findsOneWidget);
    expect(find.text('joined teams'), findsOneWidget);
    expect(find.text('invite requests'), findsOneWidget);
    expect(find.text('menu to lead to other pages'), findsOneWidget);
  });
}
