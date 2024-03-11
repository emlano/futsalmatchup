class Team {
  late final String id;
  String name = "";

  Team(this.id, this.name);

  Team.fromMap(Map<String, dynamic> map) {
    id = map['team_id']!;
    name = map['team_name']!;
  }

  Map<String, dynamic> toMap() {
    return {'team_id': id, 'team_name': name};
  }

  @override
  String toString() => toMap().toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Team && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
