import 'package:flutter/material.dart';
import 'package:frontend/resources//icon_fonts.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          centerTitle: true,
          title: const Text(
            'Futsal MatchUp',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
                wordSpacing: 5,
                fontFamily: 'DancingScript'
            ),
          ),
          leading: const Icon(
            IconFont.soccerBall,
            size: 35,
          ),
        ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter'
            ),
          ),
          TextButton(
            onPressed: () { Navigator.pushNamed(context, 'login-page'); },
            child: const Text(
              "Log in!",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.teal
              ),
            ),
          )
        ],),
    );
  }
}