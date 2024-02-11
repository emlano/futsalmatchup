import 'package:flutter/material.dart';

class PlayerRatingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Player Ratings',
          style: TextStyle(fontSize: 30.0, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        toolbarHeight: 130.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Player Cards
              PlayerCard(
                playerName: 'Player Name 1',
                playerPosition: 'Winger',
                teamName: 'Team A',
                starRating: 4,
                imagePath: 'assets/images/profileImage.jpg',
              ),
              PlayerCard(
                playerName: 'Player Name 2',
                playerPosition: 'pivot',
                teamName: 'Team B',
                starRating: 5,
                imagePath: 'assets/images/profileImage.jpg',
              ),
              PlayerCard(
                playerName: 'Player Name 3',
                playerPosition: 'Defender',
                teamName: 'Team A',
                starRating: 3,
                imagePath: 'assets/images/profileImage.jpg',
              ),
              PlayerCard(
                playerName: 'Player Name 4',
                playerPosition: 'Goalkeeper',
                teamName: 'Team D',
                starRating: 4,
                imagePath: 'assets/images/profileImage.jpg',
              ),
              PlayerCard(
                playerName: 'Player Name 5',
                playerPosition: 'Winger',
                teamName: 'Team E',
                starRating: 2,
                imagePath: 'assets/images/profileImage.jpg',
              ),
              PlayerCard(
                playerName: 'Player Name 6',
                playerPosition: 'Goalkeeper',
                teamName: 'Team F',
                starRating: 5,
                imagePath: 'assets/images/profileImage.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerCard extends StatelessWidget {
  final String playerName;
  final String playerPosition;
  final String teamName;
  final int starRating;
  final String imagePath;

  PlayerCard({
    required this.playerName,
    required this.playerPosition,
    required this.teamName,
    required this.starRating,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: Color(0xFFE0FFFF),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.teal,
                  width: 1.5, // Set the width of the border
                ),
              ),
              child: CircleAvatar(
                radius: 30.0,
                foregroundColor: Colors.teal,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerName,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Position: $playerPosition',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Team: $teamName',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 24.0,
                ),
                Text('$starRating/5'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
