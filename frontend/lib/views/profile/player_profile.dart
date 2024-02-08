import 'package:flutter/material.dart';

class PlayerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Profile'),
        backgroundColor:
            Color(0xFF008080), // Background color of the upper title area
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PlayerProfileCard(),
    );
  }
}

class PlayerProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Small player image (placeholder)
          CircleAvatar(
            radius: 60.0, // Smaller radius for the profile image
            // backgroundImage: AssetImage(''), // Replace with actual image
          ),
          SizedBox(height: 16.0),
          // Player Name
          Text(
            'Player Name',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          // Star ratings
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 24.0),
              Icon(Icons.star, color: Colors.amber, size: 24.0),
              Icon(Icons.star, color: Colors.amber, size: 24.0),
              Icon(Icons.star, color: Colors.amber, size: 24.0),
              Icon(Icons.star_border, color: Colors.amber, size: 24.0),
            ],
          ),
          SizedBox(height: 8.0),
          // Age and Team
          Text(
            '25 years old',
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            'Team Phoenix',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 16.0),
          // Player jersey and position (commented out placeholder)
          // Row(
          //   children: [
          //     Image.asset(
          //       'assets/jersey_placeholder.png',
          //       width: 50.0,
          //       height: 50.0,
          //     ),
          //     SizedBox(width: 16.0),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Jersey Number: 10',
          //           style: TextStyle(fontSize: 18.0),
          //         ),
          //         Text(
          //           'Player Position: Forward',
          //           style: TextStyle(fontSize: 18.0),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          SizedBox(height: 16.0),
          // Slider with Player Information
          Expanded(
            child: PlayerInfoSliderCard(),
          ),
        ],
      ),
    );
  }
}

class PlayerInfoSliderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        side: BorderSide(
          color: Color(0xFF008080), // Border color of the PlayerInfoSliderCard
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Player Info Slider
            PlayerInfoSlider(),
            SizedBox(height: 16.0),
            // Centered Player Information Text
            Center(
              child: Text(
                'Player Information',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerInfoSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace the data with the actual player information
    List<Map<String, dynamic>> playerInfoRow1 = [
      {'title': 'Games', 'value': '8'},
      {'title': 'Goals', 'value': '15'},
    ];

    List<Map<String, dynamic>> playerInfoRow2 = [
      {'title': 'Minutes Played', 'value': '58%'},
      {'title': 'Shots on Target', 'value': '20'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First Row
        Row(
          children: playerInfoRow1.map((info) {
            return Expanded(
              child: PlayerInfoCard(
                title: info['title'],
                value: info['value'].toString(),
                largeFont: false,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16.0),
        // Second Row
        Row(
          children: playerInfoRow2.map((info) {
            return Expanded(
              child: PlayerInfoCard(
                title: info['title'],
                value: info['value'].toString(),
                largeFont: false,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class PlayerInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final bool largeFont;

  PlayerInfoCard(
      {required this.title, required this.value, this.largeFont = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 8.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: largeFont ? 20.0 : 16.0),
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: largeFont ? 32.0 : 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
