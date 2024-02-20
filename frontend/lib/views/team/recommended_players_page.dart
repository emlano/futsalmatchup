import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';

class RecommendedPlayersPage extends StatelessWidget {
  final List<Map<String, dynamic>> recommendedPlayers;

  const RecommendedPlayersPage({Key? key, required this.recommendedPlayers}) : super(key: key);
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
              child: ListView.builder(
                itemCount: recommendedPlayers.length,
                itemBuilder: (context, index) {
                  final player = recommendedPlayers[index];
                  return Card(
                    elevation: 2.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.teal.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(player['profilePicUrl']),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style: const TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                    Text(
                                      'Rating: ${player['rating']}',
                                      style: const TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                    Text(
                                      'City: ${player['city']}',
                                      style: const TextStyle(fontSize: 16, color: Colors.black),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}