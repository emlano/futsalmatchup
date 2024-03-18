import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../providers/auth_provider.dart';

class RecommendedPlayersPage extends StatelessWidget {
  final List<Map<String, dynamic>> recommendedPlayers;

  const RecommendedPlayersPage({Key? key, required this.recommendedPlayers})
      : super(key: key);

  Future<void> _recommendPlayers(BuildContext context) async {
    try {
      final userDetails = await _getUserDetails(context);

      final response = await http.post(
        Uri.parse('http://localhost:3000/users/recommend'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userDetails),
      );

      if (response.statusCode == 200) {
        final List<dynamic> recommendedPlayersList = jsonDecode(response.body);
        print(recommendedPlayersList);
        // Handle the recommended players here
      } else {
        throw Exception('Failed to load recommended players');
      }
    } catch (e) {
      print('Error recommending players: $e');
    }
  }

  Future<Map<String, dynamic>> _getUserDetails(BuildContext context) async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? token = authProvider.token;

    // Replace this with your actual logic to fetch user details using the token
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/users'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse user details from the response
        Map<String, dynamic> userData = jsonDecode(response.body);
        return {
          'age': userData['age'],
          'player_overall_rating': userData['player_overall_rating'],
          'player_city': userData['player_city'],
        };
      } else {
        throw Exception('Failed to fetch user details');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      throw e;
    }
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
                    return ListView.builder(
                      itemCount: recommendedPlayers.length,
                      itemBuilder: (context, index) {
                        final player = recommendedPlayers[index];
                        return Card(
                          elevation: 2.0,
                          margin:
                          const EdgeInsets.symmetric(vertical: 8.0),
                          color: Colors.teal.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          player['profilePicUrl']),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            player['name'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'Age: ${player['age']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'Rating: ${player['rating']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'City: ${player['city']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle invite logic
                                  },
                                  child: const Text(
                                    'Invite to Join Team',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
}
