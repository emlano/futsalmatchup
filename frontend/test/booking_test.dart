import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/stadium/booking.dart';

void main() {
  int year = 2000;
  int month = 12;
  int day = 25;
  int minute = 00;

  DateTime a = DateTime(year, month, day, 8, minute); // 8AM
  DateTime b = DateTime(year, month, day, 9, minute); // 9AM
  DateTime c = DateTime(year, month, day, 10, minute); // 10AM
  DateTime d = DateTime(year, month, day, 11, minute); // 11AM
  DateTime e = DateTime(year, month, day, 12, minute); // 12PM

  Booking x = Booking(a, c); // 8 - 10
  Booking y = Booking(b, d); // 9 - 11
  Booking z = Booking(c, e); // 10 - 12
  Booking x2 = Booking(a, c); // Same as 'x'

  test("Testing Booking overlap detection", () {
    expect(x.overlaps(y), true); // Must overlap
    expect(y.overlaps(z), true); // Must overlap
    expect(x.overlaps(x2), true); // Same booking, Must overlap

    expect(x.overlaps(z), false); // Must not overlap
  });
}
