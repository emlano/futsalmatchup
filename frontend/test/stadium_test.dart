import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/logic/stadium/booking.dart';
import 'package:frontend/logic/stadium/stadium.dart';

void main() {
  List<Booking> bookingList = List.generate(10,
      (index) => Booking(createDateTime(index), createDateTime(index + 11)));

  Stadium stdm =
      Stadium('ABCD1234', 'Colombo', 'Colombo Futsal Club', bookingList);

  test("Test stadium class", () {
    Stadium stdm2 = Stadium.fromMap(stdm.toMap());

    // Test if both constructors create identical objects
    expect(stdm == stdm2, true);
  });
}

DateTime createDateTime(int drag) {
  return Booking.dateFromInts(2000 + drag, 01 + drag, 01 + drag, 10, 30);
}
