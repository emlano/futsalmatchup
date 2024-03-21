import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

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
                    return Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      color: Colors.teal.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Recommended Player:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Username: ${recommendedPlayer['username']}',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Text(
                              'Age: ${recommendedPlayer['age']}',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Text(
                              'City: ${recommendedPlayer['player_city']}',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Text(
                              'Overall Rating: ${recommendedPlayer['player_overall_rating']}',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            ElevatedButton(
                              onPressed: () => addToTeam(recommendedPlayer['username']),
                              child: Text('Add to team'),
                            ),
                          ],
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

      // if (response.statusCode == 200) {
      //   final List<dynamic> body = jsonDecode(response.body);
      //   final Map<String, dynamic> recommendedPlayer = body[0];
      //   return recommendedPlayer;
      // }
      final List<dynamic> body = jsonDecode(response.body);
      final Map<String, dynamic> recommendedPlayer = body[0];
      return recommendedPlayer;
      // else {
      //   throw Exception('Failed to load recommended player. Status code: ${response.statusCode}. Response body: ${response.body}');
      // }
    } catch (e) {
      print('Error recommending players: $e');
      throw e;
    }
  }
}
