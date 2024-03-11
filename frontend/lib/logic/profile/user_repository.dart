import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  // Adjust the base API URL according to your backend
  final String baseUrl = 'http://localhost:3000';

  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> profileData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/$userId'),
        body: json.encode(profileData),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // Profile update successful
        print('User profile updated successfully!');
      } else {
        // Handle errors based on the response status code
        throw Exception(
            'Failed to update user profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or unexpected errors
      print('Error updating user profile: $e');
      throw Exception(
          'Failed to update user profile. Check your network connection.');
    }
  }
}
//After you get nadil's code
// use that to connect this page (user's login/sign in details be saved as the player name, phone number)