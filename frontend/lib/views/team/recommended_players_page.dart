import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../models/header_app_bar.dart';
import '../../providers/auth_provider.dart';

// Class for the Recommended Players Page
class RecommendedPlayersPage extends StatelessWidget {
  final Function(String)
      addToTeamCallback; // Callback function to add players to the team

  RecommendedPlayersPage({required this.addToTeamCallback});

  // Function to add a player to the team
  void addToTeam(String playerName) {
    print('Player added to team');
    addToTeamCallback(playerName); // Calling the callback function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title of the page
            const Text(
              'Recommended Players for You',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: _recommendPlayers(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final recommendedPlayer =
                        snapshot.data as Map<String, dynamic>;
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 2.0,
                          color: Colors.teal.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Recommended Player:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                _buildPlayerInfo(
                                  'Username',
                                  recommendedPlayer['username'],
                                ),
                                _buildPlayerInfo(
                                  'Age',
                                  recommendedPlayer['age'].toString(),
                                ),
                                _buildPlayerInfo(
                                  'City',
                                  recommendedPlayer['player_city'],
                                ),
                                _buildPlayerInfo(
                                  'Overall Rating',
                                  recommendedPlayer['player_overall_rating']
                                      .toString(),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () =>
                                      addToTeam(recommendedPlayer['username']),
                                  child: Text('Add to Team'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerInfo(String label, String value) {
    return Text(
      '$label: $value',
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  Future<Map<String, dynamic>> _recommendPlayers(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context);
      final String? token = authProvider.token;

      final response = await http.post(
        Uri.parse(
            'http://35.213.185.204:3000/users/recommend'), // API endpoint for recommending players
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token' // Send token for authentication
        },
        body: jsonEncode(
            {}), // Send an empty body since we only need the token for authentication
      );

      final List<dynamic> body = jsonDecode(response.body);
      final Map<String, dynamic> recommendedPlayer = body[0];
      return recommendedPlayer; // Return recommended player information
    } catch (e) {
      print('Error recommending players: $e');
      throw e;
    }
  }
}
