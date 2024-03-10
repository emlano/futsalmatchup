import 'package:frontend/logic/user/user.dart';

class Manager extends User {
  Manager(int userId, String username, String password, String phoneNo)
      : super(userId, username, password, phoneNo);

  Manager.fromMap(Map<String, dynamic> map) : super.fromJSON(map);
}
