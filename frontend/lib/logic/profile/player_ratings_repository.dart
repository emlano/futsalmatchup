//PlayerRatingsRepository class, which is responsible for
//making HTTP requests to rate a player
//and the PlayerRatingPage widget that utilizes
//this repository to allow users to rate a player.

import 'dart:convert';
import 'package:http/http.dart' as http;

// PlayerRatingsRepository class for handling player rating-related API requests
class PlayerRatingsRepository {
  // Base URL for the backend API
  final String baseUrl = 'http://localhost:3000';

  // Method to send a player rating to the backend
  Future<void> ratePlayer(String userId, double skillLevelRating,
      double sportsmanshipRating) async {
    try {
      // Send a POST request to the 'players/rate' endpoint with the user's ratings
      final response = await http.post(
        Uri.parse('$baseUrl/players/rate'),
        body: json.encode({
          'userId': userId,
          'skillLevelRating': skillLevelRating,
          'sportsmanshipRating': sportsmanshipRating,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print('Player rated successfully!');
      } else {
        throw Exception(
            'Failed to rate player. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error rating player: $e');
      throw Exception('Failed to rate player. Check your network connection.');
    }
  }
}
