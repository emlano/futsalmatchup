import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/header_app_bar.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class PlayerSearchPage extends StatefulWidget {
  const PlayerSearchPage({Key? key}) : super(key: key);

  @override
  _PlayerSearchPageState createState() => _PlayerSearchPageState();
}

class _PlayerSearchPageState extends State<PlayerSearchPage> {
  late TextEditingController playerNameController;
  late AuthProvider authProvider;
  Map<String, dynamic>? playerDetails;

  @override
  void initState() {
    super.initState();
    playerNameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(context);
  }

  Future<void> fetchPlayerDetails(String playerName) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/users/other'),
        body: json.encode([{"username": playerName}]),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${authProvider.token}",
        },
      );

      if (response.statusCode == 200) {
        final dynamic playerJson = json.decode(response.body);
        setState(() {
          playerDetails = playerJson[0];
        });
      } else {
        throw Exception('Failed to load player details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void addToTeam() {
    print('Player added to team');
  }
  void ratePlayer() {
    print('Rate player');
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: playerNameController,
              decoration: InputDecoration(
                labelText: 'Enter player name',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal[100]!),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String playerName = playerNameController.text;
                await fetchPlayerDetails(playerName);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal[100],
              ),
              child: Text(
                'Search',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            playerDetails != null
                ? Column(
              children: [
                Text(
                  'Player Name: ${playerDetails!['username']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Age: ${playerDetails!['age']}',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'City: ${playerDetails!['player_city']}',
                  style: TextStyle(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: addToTeam,
                      child: Text('Add to team'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: ratePlayer,
                      child: Text('Rate Player'),
                    ),
                  ],
                ),
              ],
            )
                : const SizedBox(), // Show nothing if details are not fetched yet
          ],
        ),
      ),
    );
  }
}