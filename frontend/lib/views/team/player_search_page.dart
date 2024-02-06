import 'package:flutter/material.dart';

class PlayerSearchPage extends StatefulWidget {
  const PlayerSearchPage({Key? key}) : super(key: key);

  _PlayerSearchPageState createState() => _PlayerSearchPageState();
}

class _PlayerSearchPageState extends State<PlayerSearchPage> {
  final List<Map<String, dynamic>> players = [
    {
      "name": "Nadil",
      "city": "Bambalapitya",
      "profilePicUrl": ""
    },
    {
      "name": "Lenmini",
      "city": "Dehiwala",
      "profilePicUrl": ""
    },
    {
      "name": "Rimaz",
      "city": "Dehiwala",
      "profilePicUrl": ""
    },
    {
      "name": "Ahmed",
      "city": "Kollupitiya",
      "profilePicUrl": ""
    },
    {
      "name": "Rachel",
      "city": "Boralesgamuwa",
      "profilePicUrl": ""
    },
  ];
  List<Map<String, dynamic>> filteredPlayers = [];

  @override
  void initState() {
    filteredPlayers = List.from(players);
    super.initState();
  }

  void filterPlayers(String query) {
    setState(() {
      filteredPlayers = players
          .where((player) =>
      player['name'].toLowerCase().contains(query.toLowerCase()) ||
          player['city'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
            Image.asset(
              'assets/icons/app_icon.png',
              width: 40,
              height: 40,
              color: Colors.teal,
            ),
            const SizedBox(width: 8),
            const Text('Futsal MatchUp'),
            ],
          ),
        ),
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
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      filterPlayers(value);
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search by player name or city',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Filter players by city
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade100,
                    ),
                    child: const Text(
                      'Filter by City',
                      style: TextStyle(color: Colors.black),
                    ),
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
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal.shade100,
                      backgroundImage: NetworkImage(player['profilePicUrl']),
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
