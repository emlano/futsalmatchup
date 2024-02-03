import 'package:flutter/material.dart';

class PlayerSearchPage extends StatefulWidget {
  const PlayerSearchPage({Key? key}) : super(key: key);

  _PlayerSearchPageState createState() => _PlayerSearchPageState();
}

class _PlayerSearchPageState extends State<PlayerSearchPage> {
  final List<Map<String, dynamic>> players = [
    {
      "name": "Nadil",
      "city": "Bambalapitya",
      "profilePicUrl": ""
    },
    {
      "name": "Lenmini",
      "city": "Dehiwala",
      "profilePicUrl": ""
    },
    {
      "name": "Rimaz",
      "city": "Dehiwala",
      "profilePicUrl": ""
    },
    {
      "name": "Ahmed",
      "city": "Kollupitiya",
      "profilePicUrl": ""
    },
    {
      "name": "Rachel",
      "city": "Boralesgamuwa",
      "profilePicUrl": ""
    },
  ];
  List<Map<String, dynamic>> filteredPlayers = [];

  @override
  void initState() {
    filteredPlayers = List.from(players);
    super.initState();
  }

  void filterPlayers(String query) {
    setState(() {
      filteredPlayers = players
          .where((player) =>
      player['name'].toLowerCase().contains(query.toLowerCase()) ||
          player['city'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Row(
        children: [
        Image.asset(
        'assets/app_logo.png',
        width: 40,
        height: 40,
        color: Colors.teal,
    ),
    const SizedBox(width: 8),
    const Text('Futsal MatchUp'),
    ],
    ),
    ),
  },}