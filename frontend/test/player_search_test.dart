import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/team/player_search_page.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/auth_provider.dart';

void main() {
  testWidgets('PlayerSearchPage UI Test', (WidgetTester tester) async {
    // Call the widget tree with MaterialApp containing the PlayerSearchPage wrapped in a ChangeNotifierProvider
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>(
          create: (_) => MockAuthProvider(), // Use the mock provider
          child: PlayerSearchPage(),
        ),
      ),
    );

    // Verify the presence of widgets on PlayerSearchPage
    expect(find.byType(TextField), findsOneWidget); // Checks if the TextField is present
    expect(find.text('Search'), findsOneWidget); // Checks if the 'Search' text is present
  });
}

// Mock AuthProvider to simulate authentication behavior
class MockAuthProvider extends AuthProvider {
  String? _token;

  @override
  String? get token => _token; // Override getter to return simulated token

  @override
  void setToken(String token) {
    _token = token; // Sets the simulated token
    notifyListeners(); // Notifies listener to simulate real behavior
  }

  @override
  void removeToken() {
    _token = null; // Removes the simulated token
    notifyListeners(); // Notifies listener to simulate real behavior
  }
}

