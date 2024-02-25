import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'successful_page.dart';

class PlayerRatingPage extends StatefulWidget {
  @override
  _PlayerRatingPageState createState() => _PlayerRatingPageState();
}

class _PlayerRatingPageState extends State<PlayerRatingPage> {
  double skillLevelRating = 0;
  double sportsmanshipRating = 0;
  double overallRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 400,
                ),
                child: Card(
                  color: Color(0xFFC2FBED),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Player Name',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 180,
                          height: 180,
                          child: Image.asset(
                            'assets/profileImage.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Player Position'),
                        Text('Age'),
                        Text('Team Name'),
                        SizedBox(height: 20),
                        Text('Rate the player:',
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Skill Level
                            Text('Skill Level:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            RatingBar.builder(
                              initialRating: skillLevelRating,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 28,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  skillLevelRating = rating;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Sportsmanship
                            Text('Sportsmanship:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            RatingBar.builder(
                              initialRating: sportsmanshipRating,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 28,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  sportsmanshipRating = rating;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Overall Rating
                            Text('Overall Rating:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            RatingBar.builder(
                              initialRating: overallRating,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 28,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  overallRating = rating;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessfulPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: Size(180, 45),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
