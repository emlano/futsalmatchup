import 'package:frontend/errors/bad_request.dart';
import 'package:frontend/errors/login_info_incorrect.dart';
import 'package:frontend/errors/server_error.dart';
import 'package:frontend/errors/user_not_found.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class UserApi {
  static Future<http.Response> createUser(Map user) async {
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

    } else {
      return res;
    }
  }
}

Future<String> getUserToken(String username, String password) async {
  Map<String, String> player = {
    "username": username,
    "password": password
  };

    Response res = await UserApi.createUser(player);
    String token = jsonDecode(res.body)['accessToken']!;
    return token;
}
