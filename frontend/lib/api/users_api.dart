import 'package:http/http.dart' as http;
import 'dart:convert';

import '../logic/user/user.dart';

class UserApi {
  static Future<http.Response> createUser(Map user) async {
    final res = await http.post(Uri.parse('http://localhost:3000/users/login'),
        body: json.encode([user]),
        headers: {"Content-Type": "application/json"});

    if (res.statusCode == 200) {
      return res;
    } else {
      throw Exception(jsonDecode(res.body)['error']);
    }
  }
}
