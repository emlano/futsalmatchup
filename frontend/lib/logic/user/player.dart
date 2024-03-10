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
  Player.fromJSON(Map<String, dynamic> json)
      : sportsmanship = json['player_sportsmanship_rating'],
        overall = json['player_overall_rating'],
        city = json['player_city'],
        availability = json['player_availability'],
        skill = json['player_skill_rating'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
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
  String toString() => toJson().toString();
}
