import 'package:frontend/user/user.dart';

class Player extends User {
  double skill;
  double sportsmanship;
  double overall;
  String city;
  bool availability;

  Player(
      String userId,
      String username,
      String password,
      String phoneNo,
      this.skill,
      this.sportsmanship,
      this.overall,
      this.city,
      this.availability)
      : super(userId, username, password, phoneNo);

  @override
  Player.fromMap(Map<String, dynamic> map)
      : sportsmanship = map['sportsmanship'],
        overall = map['overall'],
        city = map['city'],
        availability = map['availability'],
        skill = map['skill'],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map.addAll({
      'skill': skill,
      'sportsmanship': sportsmanship,
      'overall': overall,
      'city': city,
      'availability': availability
    });

    return map;
  }
}
