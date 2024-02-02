import 'package:flutter/material.dart';

class CreateTeamPage extends StatelessWidget {
  const CreateTeamPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    String? teamName;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/app_logo.png',
              width: 40,
              height: 40,
            )
            const SizedBox(width: 8),
            const Text("Futsal MatchUp"),
          ],
        ),
      ),
    )
  }
}