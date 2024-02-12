import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/stadium/stadium_availability_page.dart';

void main() {
  testWidgets('StadiumAvailabilityPage UI Test', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: StadiumAvailabilityPage()));

    expect(find.text('Futsal MatchUp'), findsOneWidget);
    expect(find.text('Select a Stadium'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}