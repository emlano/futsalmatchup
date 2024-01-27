import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/user/manager.dart';
import 'package:frontend/user/player.dart';

void main() {
  test("Test User methods", () {
    String id = '1234';
    String username = 'emilano';
    String password = 'password';
    String phoneNo = '123456789';
    double sport = 19.99;
    double skill = 20.01;
    double overall = 25.55;
    String city = 'Colombo';
    bool aval = true;

    // Create maps for a player and a manager
    Map<String, dynamic> playerMap = {
      'userId': '${id}5',
      'username': username,
      'password': password,
      'phoneNo': phoneNo,
      'sportsmanship': sport,
      'overall': overall,
      'skill': skill,
      'city': city,
      'availability': aval
    };

    Map<String, dynamic> managerMap = {
      'userId': '${id}6',
      'username': username,
      'password': password,
      'phoneNo': phoneNo
    };

    Player p = Player('${id}5', username, password, phoneNo, skill, sport,
        overall, city, aval);

    Player pClone = Player.fromMap(playerMap);

    Manager m = Manager('${id}6', username, password, phoneNo);

    Manager mClone = Manager.fromMap(managerMap);

    // Test if both constructors create identical objs
    expect(p == pClone, true);
    // Test if the map returned by the object is the same as the
    // used to build it
    expect(p.toMap(), playerMap);

    expect(m == mClone, true);
    expect(m.toMap(), managerMap);
  });
}
