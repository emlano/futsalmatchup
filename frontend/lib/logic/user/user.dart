abstract class User {
  // More instance variables may be added as requirements grow
  final int userId;
  final String username;
  String password;
  String phoneNo;

  // Constructor
  User(
    this.userId,
    this.username,
    this.password,
    this.phoneNo,
  );

  // Named constructor
  User.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        username = json['username'],
        password = json['password'],
        phoneNo = json['phone_no'];

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'password': password,
      'phone_no': phoneNo
    };
  }

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is User && userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
