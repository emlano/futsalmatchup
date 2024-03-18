import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/team/player_search_page.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/auth_provider.dart'; // Import your provider

void main() {
  testWidgets('PlayerSearchPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>(
          create: (_) => MockAuthProvider(), // Use the mock provider
          child: PlayerSearchPage(),
        ),
      ),
    );

    // Verify the presence of widgets on PlayerSearchPage
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
  });
}

// Mock AuthProvider
class MockAuthProvider extends AuthProvider {
  String? _token;

  @override
  String? get token => _token;

  @override
  void setToken(String tkn) {
    _token = tkn;
    notifyListeners(); // Notify listeners to simulate real behavior
  }

  @override
  void removeToken() {
    _token = null;
    notifyListeners(); // Notify listeners to simulate real behavior
  }
}

