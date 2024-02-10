import 'package:flutter/material.dart';
import 'player_search_page.dart';

class TeamRosterPage extends StatelessWidget {
  final String teamName;

  const TeamRosterPage({Key? key, required this.teamName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> teamPlayers = [
      {"name": 'Nadil', "profilePicUrl": 'assets/images/player_icon.png'},
      {"name": 'Ahmed', "profilePicUrl": 'assets/images/player_icon.png'},
      {"name": 'Rimaz', "profilePicUrl": 'assets/images/player_icon.png'},
      {"name": 'Lenmini', "profilePicUrl": 'assets/images/player_icon.png'},
      {"name": 'Rachel', "profilePicUrl": 'assets/images/player_icon.png'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/app_icon.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text(
              "Futsal MatchUp",
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  teamName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Team Members',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: teamPlayers.length,
                        itemBuilder: (context, index) {
                          final player = teamPlayers[index];
                          return ListTile(
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                                ),
                              ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(player['profilePicUrl']),
                                ),
                              ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(player['name']),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PlayerSearchPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade100,
                      ),
                      child: const Text(
                        '+ Find Players',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}