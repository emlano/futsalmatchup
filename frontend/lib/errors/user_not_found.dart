class UserNotFoundException implements Exception {
  static const String message = "No such user found!";
  UserNotFoundException();
}
