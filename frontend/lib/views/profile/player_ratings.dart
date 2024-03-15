import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/logic/profile/player_ratings_repository.dart';
import 'successful_page.dart';

class PlayerRatingPage extends StatefulWidget {
  final int playerId;
  final String playerName;

  // Constructor to initialize playerId and playerName
  PlayerRatingPage({required this.playerId, required this.playerName});

  @override
  _PlayerRatingPageState createState() => _PlayerRatingPageState();
}

class _PlayerRatingPageState extends State<PlayerRatingPage> {
  double skillLevelRating = 0;
  double sportsmanshipRating = 0;

  // Instantiate PlayerRatingsRepository to handle backend interactions
  final PlayerRatingsRepository playerRatingsRepository =
      PlayerRatingsRepository();

  // Map to store player details fetched from the backend
  late Map<String, dynamic> playerDetails = {};

  @override
  void initState() {
    super.initState();
    // Fetch player details when the widget is initialized
    fetchPlayerDetails();
  }

  // Function to fetch player details from backend
  Future<void> fetchPlayerDetails() async {
    try {
      final fetchedPlayerDetails =
          await playerRatingsRepository.getPlayerDetails(widget.playerId);
      setState(() {
        playerDetails = fetchedPlayerDetails;
      });
    } catch (e) {
      print('Error fetching player details: $e');
    }
  }

  Future<void> updatePlayerRatings() async {
    try {
      await playerRatingsRepository.updatePlayerRatings(
        widget.playerId,
        skillLevelRating,
        sportsmanshipRating,
      );

      // Show success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Player ratings updated successfully'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle any errors during the update
      print('Error updating player ratings: $e');

      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating player ratings. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

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
                          playerDetails['username'] ?? 'Player Name',
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
                        Text(playerDetails['player_position'] ??
                            'Player Position'),
                        Text(playerDetails['age']?.toString() ?? 'Age'),
                        Text(playerDetails['player_city'] ?? 'City'),
                        SizedBox(height: 20),
                        Text('Rate the player:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Skill Level
                            Text('Skill Level:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Call the updatePlayerRatings method to update the backend with the ratings
                    await updatePlayerRatings();
                    // Navigate to the successful page after successfully rating the player
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessfulPage(),
                      ),
                    );
                  } catch (e) {
                    print('Error rating player: $e');
                    // Handle error
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
