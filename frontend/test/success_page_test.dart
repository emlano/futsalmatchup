import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/profile/successful_page.dart';

void main() {
  testWidgets('SuccessfulPage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SuccessfulPage()));

    // To Verify the initial state is as expected.
    expect(find.text('Rating Successfully'), findsOneWidget);
    expect(find.text('Submitted!'), findsOneWidget);

    // To Verify the appearance of the back arrow button
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Tap on the back arrow button and to verify if it navigates back
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle(); // Wait for animations to complete

    // To Verify the navigation happened
    expect(find.text('Rating Successfully'), findsNothing);
    expect(find.text('Submitted!'), findsNothing);
  });
}
