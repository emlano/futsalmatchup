import 'package:frontend/user/player.dart';

class Team {
  late final String id;
  String name = "";
  List<Player> members = [];

  Team(this.id, this.name, this.members);
  Team.create(this.id, this.name) : members = List.empty(growable: true);

  Team.fromMap(Map<String, dynamic> map) {
    id = map['id']!;
    name = map['name']!;

    List<Map<String, dynamic>> playerList = map['members']!;

    members = playerList.map((e) => Player.fromMap(e)).toList(growable: true);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'members': members.map((e) => e.toMap()).toList()
    };
  }

  addPlayer(Player player) {
    if (members.length == 6) return; // TODO handle this
    if (members.contains(player)) return; // TODO handle this
    members.add(player);
  }

  @override
  String toString() => toMap().toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Team && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
