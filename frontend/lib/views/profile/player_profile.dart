import 'package:flutter/material.dart';

class PlayerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Profile'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Add border to the profile image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.teal,
                    width: 2.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage('assets/images/profileImage.jpg'),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Dion Fernandez',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
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
              Text(
                '25 years old',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Team Phoenix',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              // Center the jersey details
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the contents
                children: [
                  Image.asset(
                    'assets/images/jersey.png',
                    width: 40.0,
                    height: 40.0,
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jersey Number: 18',
                        style: TextStyle(fontSize: 13.0),
                      ),
                      Text(
                        'Player Position: Forward',
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              PlayerInfoSliderCard(),
            ],
          ),
        ),
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
          color: Colors.teal,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            PlayerInfoSlider(),
            SizedBox(height: 16.0),
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
