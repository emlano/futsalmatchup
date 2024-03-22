import 'package:flutter/material.dart';
import 'player_search_page.dart';
import 'recommended_players_page.dart';
import 'package:frontend/models/header_app_bar.dart';

// Create a StatefulWidget for the team roster page
class TeamRosterPage extends StatefulWidget {
  final String teamName;

  const TeamRosterPage({Key? key, required this.teamName}) : super(key: key);

  @override
  _TeamRosterPageState createState() => _TeamRosterPageState();
}

class _TeamRosterPageState extends State<TeamRosterPage> {
  // List to hold team players data
  List<Map<String, dynamic>> teamPlayers = [
    {"name": 'Ahmed Zavahir', "profilePicUrl": 'assets/images/player_icon.png'},
  ];

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
            // Display team name
            Center(
              child: Text(
                widget.teamName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Header for team members
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
                    // Display team members list
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

                  // Button to add players through player search
                  ElevatedButton(
                    onPressed: () async {
                      final addedPlayer = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(builder: (context) => const PlayerSearchPage()),
                      );
                      if (addedPlayer != null) {
                        setState(() {
                          teamPlayers.add({"name": addedPlayer, "profilePicUrl": 'assets/images/player_icon.png'});
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade100,
                    ),
                    child: const Text(
                      '+ Search Players',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),

                  // Button to see recommended players matching the team
                  ElevatedButton(
                    onPressed: () async {
                      final addedPlayer = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(builder: (context) => RecommendedPlayersPage(
                          addToTeamCallback: (playerName) {
                            setState(() {
                              teamPlayers.add({"name": playerName, "profilePicUrl": 'assets/images/player_icon.png'});
                            });
                          },
                        )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade100,
                    ),
                    child: const Text(
                      'See Players that Match Your Team',
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