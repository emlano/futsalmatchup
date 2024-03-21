import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../models/header_app_bar.dart';
import '../../providers/auth_provider.dart';

class RecommendedPlayersPage extends StatelessWidget {
  final Function(String) addToTeamCallback;

  RecommendedPlayersPage({required this.addToTeamCallback});

  void addToTeam(String playerName) {
    print('Player added to team');
    addToTeamCallback(playerName);
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
                    final recommendedPlayer = snapshot.data as Map<String, dynamic>;
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
                                  onPressed: () => addToTeam(
                                      recommendedPlayer['username']),
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
        Uri.parse('http://localhost:3000/users/recommend'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({}), // Sending an empty body since we only need the token for authentication
      );

      final List<dynamic> body = jsonDecode(response.body);
      final Map<String, dynamic> recommendedPlayer = body[0];
      return recommendedPlayer;
    } catch (e) {
      print('Error recommending players: $e');
      throw e;
    }
  }
}
