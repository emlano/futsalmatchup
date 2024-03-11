import 'package:frontend/errors/bad_request.dart';
import 'package:frontend/errors/login_info_incorrect.dart';
import 'package:frontend/errors/server_error.dart';
import 'package:frontend/errors/user_not_found.dart';
import 'package:frontend/errors/username_taken.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class UserApi {
  static Future<http.Response> loginUser(Map user) async {
    final res = await http.post(Uri.parse('http://localhost:3000/users/login'),
        body: json.encode([user]),
        headers: {"Content-Type": "application/json"});

    if (res.statusCode == 401) {
      throw BadLoginInfoException();
    } else if (res.statusCode == 404) {
      throw UserNotFoundException();
    } else if (res.statusCode == 400) {
      throw BadRequestException();
    } else if (res.statusCode == 500) {
      throw ServerErrorException();
    }

    return res;
  }

  static Future<http.Response> signupUser(Map user) async {
    final res = await http.post(Uri.parse('http://localhost:3000/users/signup'),
        body: json.encode([user]),
        headers: {"Content-Type": "application/json"});

    if (res.statusCode == 400) {
      throw BadRequestException();
    } else if (res.statusCode == 409) {
      throw UsernameAlreadyTaken();
    } else if (res.statusCode == 500) {
      throw ServerErrorException();
    }

    return res;
  }
}

Future<String> getUserTokenWhenLogin(String username, String password) async {
  Map<String, String> player = {"username": username, "password": password};

  Response res = await UserApi.loginUser(player);
  String token = jsonDecode(res.body)['accessToken']!;
  return token;
}

Future<String> getUserTokenWhenSignup(
    String username, String password, String phoneNo) async {
  Map<String, String> player = {
    "username": username,
    "password": password,
    "phone_no": phoneNo
  };

  Response res = await UserApi.signupUser(player);
  String token = jsonDecode(res.body)['accessToken']!;
  return token;
}
