abstract class User {
  // More instance variables may be added as requirements grow
  String userId;
  String username;
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
  User.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        username = map['username'],
        password = map['password'],
        phoneNo = map['phoneNo'];

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'password': password,
      'phoneNo': phoneNo
    };
  }
}
