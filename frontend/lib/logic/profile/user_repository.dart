import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  // Method to fetch user profile data from backend
  Future<Map<String, dynamic>> getUserProfile(String? token) async {
    try {
      if (token != null) {
        final response = await http.get(
          Uri.parse('http://35.213.185.204:3000/users/'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        // Handle response status code
        if (response.statusCode == 200) {
          // Parse and return user profile data
          final List<dynamic> body = jsonDecode(response.body);
          final userProfile = body[0];
          return userProfile;
        } else if (response.statusCode == 400) {
          // Bad request - client-side error
          print('Bad request: ${response.body}');
          throw Exception('Bad request');
        } else if (response.statusCode >= 500) {
          // Server error
          print('Server error: ${response.body}');
          throw Exception('Server error');
        } else {
          // Handle other status codes
          print(
              'Failed to fetch user profile. Status code: ${response.statusCode}');
          throw Exception('Failed to fetch user profile');
        }
      } else {
        // Handle error where token is not available
        throw Exception('Authentication token not available.');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      throw Exception(
          'Failed to fetch user profile. Check your network connection.');
    }
  }

  // Method to update the user profile on the backend
  Future<void> updateUserProfile(
      String? token, Map<String, dynamic> profileData) async {
    try {
      if (token != null) {
        final response = await http.put(
          Uri.parse('http://35.213.185.204:3000/users'),
          body: json.encode([profileData]),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        // Handle response status code
        if (response.statusCode == 200) {
          // Profile update successful
          print('User profile updated successfully!');
        } else if (response.statusCode == 400) {
          // Bad request - client-side error
          print('Bad request: ${response.body}');
          throw Exception('Bad request');
        } else if (response.statusCode >= 500) {
          // Server error
          print('Server error: ${response.body}');
          throw Exception('Server error');
        } else {
          // Handle other status codes
          print(
              'Failed to update user profile. Status code: ${response.statusCode}');
          throw Exception('Failed to update user profile');
        }
      } else {
        // Handle error where token is not available
        throw Exception('Authentication token not available.');
      }
    } catch (e) {
      print('Error updating user profile: $e');
      throw Exception(
          'Failed to update user profile. Check your network connection.');
    }
  }
}
