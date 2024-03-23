import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/stadium/stadium_availability_page.dart';

void main() {
  testWidgets('StadiumAvailabilityPage UI Test', (WidgetTester tester) async {

    // Call the widget to load the UI
    await tester.pumpWidget(MaterialApp(home: StadiumAvailabilityPage()));

    expect(find.text('Futsal MatchUp'), findsOneWidget); // Checks if 'Futsal MatchUp' text is found
    expect(find.text('Select a Stadium'), findsOneWidget); // Checks if 'Select a Stadium' text is found
    expect(find.byType(TextField), findsOneWidget); // Checks if the TextField widget is found
    expect(find.byType(GridView), findsOneWidget); // Checks if a GridView widget is found
  });
}