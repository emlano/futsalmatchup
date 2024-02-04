import 'package:flutter/material.dart';
import 'package:frontend/resources//icon_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 30),
          Image.asset(
              'assets/images/log_in.jpg',
            width: 300,
            height: 300,
            isAntiAlias: true,
          ),
          const SizedBox(height: 40),
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
          const SizedBox(height: 20),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40), child: TextField(
            decoration: InputDecoration(
                icon: Icon(
                    Icons.account_circle,
                    color: Colors.teal,
                  size: 35,
                ),
                border: OutlineInputBorder(),
                labelText: "Username",
                hintText: 'Enter your username',
                enabled: true,
                focusColor: Colors.teal,
                isDense: true,
                fillColor: Colors.teal,

            ),
          )),
          const SizedBox(height: 10),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40), child: TextField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.password,
                color: Colors.teal,
                size: 35,
              ),
              border: OutlineInputBorder(),
              hintText: 'Enter your password',
              labelText: "Password",
              enabled: true,
              focusColor: Colors.teal,
              isDense: true,
              fillColor: Colors.teal,
            ),
          )),
          const SizedBox(height: 20),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40), child: ElevatedButton(
              onPressed: () {  },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                minimumSize: const Size(100, 40),
                maximumSize: const Size(200, 40),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle),
                  SizedBox(width: 10),
                  Text(
                    "Log in",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ))),
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
                  "Sign up!",
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
