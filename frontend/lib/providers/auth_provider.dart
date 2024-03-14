import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  void setToken(String tkn) {
    _token = tkn;
    notifyListeners();
  }

  void removeToken() {
    _token = null;
  }
}
