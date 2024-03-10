import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:frontend/models/textboxes/text_input_box.dart';

class PlayerSearchPage extends StatefulWidget {
  const PlayerSearchPage({Key? key}) : super(key: key);

  _PlayerSearchPageState createState() => _PlayerSearchPageState();
}

class _PlayerSearchPageState extends State<PlayerSearchPage> {
  final TextEditingController playerNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final List<Map<String, dynamic>> players = [
    {
      "name": "Nadil",
      "city": "Bambalapitya",
      "profilePicUrl": "assets/images/player_icon.png"
    },
    {
      "name": "Lenmini",
      "city": "Dehiwala",
      "profilePicUrl": "assets/images/player_icon.png"
    },
    {
      "name": "Rimaz",
      "city": "Dehiwala",
      "profilePicUrl": "assets/images/player_icon.png"
    },
    {
      "name": "Ahmed",
      "city": "Kollupitiya",
      "profilePicUrl": "assets/images/player_icon.png"
    },
    {
      "name": "Rachel",
      "city": "Boralesgamuwa",
      "profilePicUrl": "assets/images/player_icon.png"
    },
  ];
  List<Map<String, dynamic>> filteredPlayers = [];

  @override
  void initState() {
    filteredPlayers = List.from(players);
    super.initState();
  }

  void filterPlayers(String query, bool filterByName) {
    setState(() {
      filteredPlayers = players.where((player) {
        if (filterByName) {
          return player['name'].toLowerCase().contains(query.toLowerCase());
        } else {
          return player['city'].toLowerCase().contains(query.toLowerCase());
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Search Players',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextInputBox(
                    // controller: playerNameController TODO,
                    name: "Player Name",
                    desc: "Enter player name",
                    icon: Icons.person,
                    length: 20,
                    onChanged: (query) => filterPlayers(query, true)
                  ),
                  const SizedBox(height: 20),
                  TextInputBox(
                    // controller: cityController TODO,
                    name: "City",
                    desc: "Enter city",
                    icon: Icons.location_city,
                    length: 20,
                    onChanged: (query) => filterPlayers(query, false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPlayers.length,
                itemBuilder: (context, index) {
                  final player = filteredPlayers[index];
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
                    title: Text(player['name']),
                    subtitle: Text(
                      player['city'],
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Invite player to join team
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade100,
                      ),
                      child: const Text(
                        'Invite to Join Team',
                        style: TextStyle(color: Colors.black),
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
