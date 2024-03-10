import 'package:frontend/logic/stadium/booking.dart';

class Stadium {
  late final int id;
  late String name;
  late String location;

  Stadium(this.id, this.location, this.name);

  Stadium.fromMap(Map<String, dynamic> map) {
    id = map['stadium_id']!;
    name = map['stadium_name']!;
    location = map['stadium_location']!;
  }

  Map<String, dynamic> toMap() {
    return {
      'stadium_id': id,
      'stadium_name': name,
      'stadium_location': location,
    };
  }

  @override
  String toString() => toMap().toString();

  @override
  bool operator ==(Object other) =>
      identical(id, other) || other is Stadium && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
