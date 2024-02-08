import 'package:flutter/material.dart';
import 'package:frontend/views/login/login_page.dart';
import 'package:frontend/views/login/login_screen.dart';
import 'package:frontend/views/login/signin_page.dart';
import 'package:frontend/views/profile/player_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futsal MatchUp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LoginScreen(title: 'Futsal MatchUp'),
      // home: PlayerProfileScreen(),
      routes: {
        "login-page": (context) => const LoginPage(),
        "signin-page": (context) => const SigninPage(),
      },
    );
  }
}
