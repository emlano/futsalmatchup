import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/login_form_provider.dart';
import 'package:frontend/views/home/Home.dart';
import 'package:frontend/views/login/login_page.dart';
import 'package:frontend/views/login/login_screen.dart';
import 'package:frontend/views/login/signin_page.dart';
import 'package:frontend/views/profile/player_profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ],
      child: MaterialApp(
        title: 'Futsal MatchUp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const LoginScreen(title: "Futsal MatchUp"),
        routes: {
          "/login": (context) => const LoginPage(),
          "/signup": (context) => const SigninPage(),
          "/home": (context) => const Home(),
          "/profile": (context) => PlayerProfile(),
        },
      ),
    );
  }
}
