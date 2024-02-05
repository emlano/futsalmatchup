import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:frontend/models/forms/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 25),
          Image.asset(
              'assets/images/log_in.jpg',
            width: 300,
            height: 300,
            isAntiAlias: true,
          ),
          const SizedBox(height: 20),
          const Text(
            "Welcome back!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Colors.teal
            ),
          ),
          const SizedBox(height: 35),
          const LoginForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter'
                ),
              ),
              TextButton(
                onPressed: () { Navigator.pushNamed(context, 'signin-page'); },
                child: const Text(
                  "Sign in!",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                      color: Colors.teal
                  ),
                ),
              )
          ],)
        ],
      ),
    );
  }
}
