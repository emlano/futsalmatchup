import 'package:frontend/stadium/booking.dart';

class Stadium {
  late String name;
  late String location;
  late List<Booking> schedule;

  Stadium(this.location, this.name, this.schedule);

  Stadium.create(this.location, this.name) : schedule = List.empty();

  Stadium.fromMap(Map<String, dynamic> map) {
    name = map['name']!;
    location = map['location']!;

    List<Map<String, Map<String, int>>> bookingList = map['schedule'];

    schedule = bookingList.map((e) => Booking.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'schedule': schedule.map((e) => e.toMap()).toList()
    };
  }
}
