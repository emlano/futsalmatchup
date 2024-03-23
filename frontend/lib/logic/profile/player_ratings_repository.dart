import 'dart:convert';
import 'package:http/http.dart' as http;

class PlayerRatingsRepository {
  // Method to update the player ratings of the player on the backend
  Future<void> updatePlayerRatings(int userId, double skillLevelRating,
      double sportsmanshipRating, String token) async {
    try {
      // Send a POST request with the user's ratings
      final response = await http.put(
        Uri.parse('http://localhost:3000/users/other'),
        body: json.encode([
          {
            'user_id': userId,
            'player_skill_rating': skillLevelRating,
            'player_sportsmanship_rating': sportsmanshipRating,
          }
        ]),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      // Handle response status code
      if (response.statusCode == 200) {
        print('Player ratings saved successfully!');
      } else if (response.statusCode == 400) {
        // Bad request - client-side error
        print('Bad request: ${response.body}');
        throw Exception('Bad request');
      } else if (response.statusCode >= 500) {
        // Server error
        print('Server error: ${response.body}');
        throw Exception('Server error');
      } else {
        throw Exception(
            'Failed to save player ratings. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error saving player ratings: $e');
      throw Exception('Failed to save player ratings.');
    }
  }
}
