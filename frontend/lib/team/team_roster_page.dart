import 'package:flutter/material.dart';

class TeamRosterPage extends StatelessWidget {
  final String teamName;

  const TeamRosterPage({Key? key, required this.teamName}) : super(key: key);

  Widget build(BuildContext context) {
    List<Map<String, dynamic>> teamPlayers = [
      {"name": 'Nadil', "profilePicPath": ''},
      {"name": 'Ahmed', "profilePicPath": ''},
      {"name": 'Rimaz', "profilePicPath": ''},
      {"name": 'Lenmini', "profilePicPath": ''},
      {"name": 'Rachel', "profilePicPath": ''},
    ];

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/app_logo.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 8),
              const Text('Futsal MatchUp'),
            ],
          ),
        ),
  }
}