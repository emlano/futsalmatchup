import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/header_app_bar.dart';
import 'dart:convert';
import 'package:frontend/views/profile/player_ratings.dart';

import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

// Define a StatefulWidget for the player search page
class PlayerSearchPage extends StatefulWidget {
  const PlayerSearchPage({Key? key}) : super(key: key);

  @override
  _PlayerSearchPageState createState() => _PlayerSearchPageState();
}

class _PlayerSearchPageState extends State<PlayerSearchPage> {
  late TextEditingController
      playerNameController; // Controller for player name text field
  late AuthProvider authProvider; // Authentication provider
  Map<String, dynamic>? playerDetails; // Details of the searched player

  @override
  void initState() {
    super.initState();
    playerNameController = TextEditingController(); // Initialize the controller
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(
        context); // Access the authentication provider
  }

  Future<void> fetchPlayerDetails(String playerName) async {
    try {
      final response = await http.post(
        Uri.parse('http://35.213.185.204:3000/users/other'), // Path to API endpoint
        body: json.encode([
          {"username": playerName}
        ]),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer ${authProvider.token}", // Send authorization token
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> playerJson = json.decode(response.body);
        setState(() {
          playerDetails =
              playerJson[0]; // Set player details received from the server
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
    Navigator.pop(context, playerNameController.text);
  }

  void ratePlayer() {
    print('Rate player');
    if (playerDetails != null) {
      // Navigate to the PlayerRatingPage
      Navigator.push(
        context,
        MaterialPageRoute(
          // Pass player details as arguments to the PlayerRatingPage constructor
          builder: (context) => PlayerRatingPage(playerInfo: playerDetails!),
        ),
      );
    } else {
      print('Player details not fetched.');
    }
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(
        context); // Access the authentication provider
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
                labelStyle: const TextStyle(color: Colors.black),
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
                backgroundColor: Colors.teal[100],
              ),
              child: const Text(
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
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        'City: ${playerDetails!['player_city']}',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: addToTeam,
                            child: const Text('Add to team'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: ratePlayer,
                            child: const Text('Rate Player'),
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
