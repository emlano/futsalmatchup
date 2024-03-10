import 'package:frontend/logic/user/user.dart';

class Player extends User {
  double skill;
  double sportsmanship;
  double overall;
  String city;
  bool availability;

  Player(
      int userId,
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
  Player.fromJSON(Map<String, dynamic> map)
      : sportsmanship = map['player_sportsmanship_rating'],
        overall = map['player_overall_rating'],
        city = map['player_city'],
        availability = map['player_availability'],
        skill = map['player_skill_rating'],
        super.fromJSON(map);

  @override
  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = super.toJSON();
    map.addAll({
      'skill': skill,
      'player_sportsmanship_rating': sportsmanship,
      'player_overall_rating': overall,
      'player_city': city,
      'player_availability': availability
    });

    return map;
  }

  @override
  String toString() => toJSON().toString();
}
