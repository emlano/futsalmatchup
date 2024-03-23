class BadLoginInfoException implements Exception {
  static const String message = "Username or password is wrong!";
  BadLoginInfoException();
}
