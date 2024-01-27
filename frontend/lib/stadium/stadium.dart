import 'package:frontend/stadium/booking.dart';

class Stadium {
  late String id;
  late String name;
  late String location;
  late List<Booking> schedule;

  Stadium(this.id, this.location, this.name, this.schedule);

  Stadium.create(this.id, this.location, this.name) : schedule = List.empty();

  Stadium.fromMap(Map<String, dynamic> map) {
    id = map['id']!;
    name = map['name']!;
    location = map['location']!;

    List<Map<String, Map<String, int>>> bookingList = map['schedule'];

    schedule = bookingList.map((e) => Booking.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'schedule': schedule.map((e) => e.toMap()).toList()
    };
  }

  addBooking(DateTime start, DateTime end) {
    Booking booking = Booking(start, end);

    if (_clashes(booking)) return; // TODO: Handle this better

    schedule.add(booking);
  }

  _clashes(Booking booking) {
    for (final i in schedule) {
      if (i.overlaps(booking)) return true;
    }

    return false;
  }

  @override
  bool operator ==(Object other) =>
      identical(id, other) || other is Stadium && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
