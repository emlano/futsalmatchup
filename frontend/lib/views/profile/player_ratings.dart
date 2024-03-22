import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/logic/profile/player_ratings_repository.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'successful_page.dart';

class PlayerRatingPage extends StatefulWidget {
  final Map<String, dynamic>
      playerInfo; // Player details received from player_search_[age]
  PlayerRatingPage({required this.playerInfo});

  @override
  _PlayerRatingPageState createState() => _PlayerRatingPageState();
}

class _PlayerRatingPageState extends State<PlayerRatingPage> {
  double skillLevelRating = 0; // Initial skill level rating
  double sportsmanshipRating = 0; // Initial sportsmanship rating

  final PlayerRatingsRepository playerRatingsRepository =
      PlayerRatingsRepository(); // Instantiate PlayerRatingsRepository

  @override
  Widget build(BuildContext context) {
    // Extract player details from the received playerInfo map
    int userId = widget.playerInfo['user_id'];
    String playerName = widget.playerInfo['username'];
    int playerAge = widget.playerInfo['age'];
    String playerCity = widget.playerInfo['player_city'];
    String playerPosition = widget.playerInfo['player_position'];

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: TitleAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Player Information Card
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
                        // Player details
                        Text(
                          '$playerName', // Display player name
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        // Player image
                        Container(
                          width: 180,
                          height: 180,
                          child: Image.asset(
                            'assets/images/profileImage.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('$playerPosition'), // Display player position
                        Text('$playerAge'), // Display player age
                        Text('$playerCity'), // Display player city

                        SizedBox(height: 20),
                        Text('Rate the player:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     // Skill Level Rating
                        //     Text('Skill Level:',
                        //         style: TextStyle(
                        //             fontSize: 18, fontWeight: FontWeight.bold)),
                        //     RatingBar.builder(
                        //       initialRating: skillLevelRating,
                        //       direction: Axis.horizontal,
                        //       allowHalfRating: true,
                        //       itemCount: 5,
                        //       itemSize: 28,
                        //       itemBuilder: (context, _) => Icon(
                        //         Icons.star,
                        //         color: Colors.yellow,
                        //       ),
                        //       onRatingUpdate: (rating) {
                        //         setState(() {
                        //           skillLevelRating = rating;
                        //         });
                        //       },
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     // Sportsmanship Rating
                        //     Text('Sportsmanship:',
                        //         style: TextStyle(
                        //             fontSize: 18, fontWeight: FontWeight.bold)),
                        //     RatingBar.builder(
                        //       initialRating: sportsmanshipRating,
                        //       direction: Axis.horizontal,
                        //       allowHalfRating: true,
                        //       itemCount: 5,
                        //       itemSize: 28,
                        //       itemBuilder: (context, _) => Icon(
                        //         Icons.star,
                        //         color: Colors.yellow,
                        //       ),
                        //       onRatingUpdate: (rating) {
                        //         setState(() {
                        //           sportsmanshipRating = rating;
                        //         });
                        //       },
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Skill Level:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: RatingBar.builder(
                                initialRating: skillLevelRating,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 28,
                                itemBuilder: (context, _) =>
                                    Icon(Icons.star, color: Colors.yellow),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    skillLevelRating = rating;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Sportsmanship:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: RatingBar.builder(
                                initialRating: skillLevelRating,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 28,
                                itemBuilder: (context, _) =>
                                    Icon(Icons.star, color: Colors.yellow),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    skillLevelRating = rating;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Call updatePlayerRatings() to update the backend with the ratings
                    await playerRatingsRepository.updatePlayerRatings(
                        userId,
                        sportsmanshipRating,
                        skillLevelRating,
                        authProvider.token!);
                    //Navigate to the successful page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessfulPage(),
                      ),
                    );
                  } catch (e) {
                    // Display error to the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to update player ratings.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    print('Error rating player: $e');
                  }
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
