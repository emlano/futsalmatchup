import 'dart:convert';
import 'package:http/http.dart' as http;

class PlayerRatingsRepository {
  // Base URL for the backend API
  final String baseUrl = 'http://localhost:3000';

  //Method to get player details (player name,age, city, player position ) of the selected player  from the backend and display in the frontend
  //get player details by userId or getUserFromName
  Future<Map<String, dynamic>> getPlayerDetails(
      dynamic playerIdentifier) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/users/other?id=${playerIdentifier['id']}&username=${playerIdentifier['username']}'),
        headers: {"Content-Type": "application/json"},
      ); //path correct??

      if (response.statusCode == 200) {
        print('Player details fetched successfully!');
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        print('Bad request: ${response.body}');
        throw Exception('Bad request');
      } else if (response.statusCode >= 500) {
        print('Server error: ${response.body}');
        throw Exception('Server error');
      } else {
        throw Exception('Failed to fetch player details');
      }
    } catch (e) {
      print('Error fetching player details: $e');
      throw Exception('Failed to fetch player details');
    }
  }

  // Method to update the player ratings of the player on the backend
  Future<void> updatePlayerRatings(dynamic playerIdentifier,
      double skillLevelRating, double sportsmanshipRating) async {
    try {
      // Send a POST request to the 'players/rate' endpoint with the user's ratings
      final response = await http.post(
        Uri.parse('$baseUrl/users/other'), //path correct??
        body: json.encode({
          'userId': playerIdentifier['user_id'],
          'skillLevelRating': skillLevelRating,
          'sportsmanshipRating': sportsmanshipRating,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print('Player rated successfully!');
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
            'Failed to rate player. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error rating player: $e');
      throw Exception('Failed to rate player. Check your network connection.');
    }
  }
}
