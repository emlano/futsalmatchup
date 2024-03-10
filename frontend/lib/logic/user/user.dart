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
  User.fromJSON(Map<String, dynamic> map)
      : userId = map['user_id'],
        username = map['username'],
        password = map['password'],
        phoneNo = map['phone_no'];

  Map<String, dynamic> toJSON() {
    return {
      'user_id': userId,
      'username': username,
      'password': password,
      'phone_no': phoneNo
    };
  }

  @override
  String toString() => toJSON().toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is User && userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
