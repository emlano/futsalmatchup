import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:frontend/models/forms/signin_form.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: TitleAppBar(),
      body: Column(
        children: [
          Image.asset(
            'assets/images/sign_in.jpg',
            width: 300,
            height: 300,
            isAntiAlias: true,
          ),
          const Text(
            "Join the party!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: Colors.teal
            ),
          ),
          const SizedBox(height: 10),
          const SigninForm(),
          Row(
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
        ],
      ),
    );
  }
}