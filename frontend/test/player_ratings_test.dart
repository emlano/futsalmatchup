// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:frontend/views/profile/player_ratings.dart';
// import 'package:frontend/views/profile/successful_page.dart';
// import 'package:frontend/providers/auth_provider.dart';
// import 'package:provider/provider.dart';

// void main() {
//   testWidgets('PlayerRatingPage Widget Test', (WidgetTester tester) async {
//     // Build the PlayerRatingPage widget with necessary providers
//     await tester.pumpWidget(
//       MaterialApp(
//         home: ChangeNotifierProvider<AuthProvider>(
//           create: (_) => AuthProvider(),
//           child: PlayerRatingPage(
//             playerInfo: {
//               'user_id': 1,
//               'username': 'John Doe',
//               'age': 25,
//               'player_city': 'New York',
//               'player_position': 'Forward',
//             },
//           ),
//         ),
//       ),
//     );

//     // Verify that the "Done" button is present
//     expect(find.text('Done'), findsOneWidget);

//     // Tap the "Done" button
//     await tester.tap(find.text('Done'));
//     await tester.pump(); // Wait for navigation

//     // Verify navigation to SuccessfulPage
//     expect(find.byType(SuccessfulPage), findsOneWidget);
//   });
// }
