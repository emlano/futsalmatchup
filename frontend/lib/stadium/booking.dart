import 'package:flutter/material.dart';

class Booking {
  late DateTimeRange bookingRange;

  Booking(DateTime start, DateTime end) {
    bookingRange = DateTimeRange(start: start, end: end);
  }

  Booking.fromMap(Map<String, Map<String, int>> map) {
    DateTime start = _dateFromMap(map['start']!);
    DateTime end = _dateFromMap(map['end']!);

    bookingRange = DateTimeRange(start: start, end: end);
  }

  Map<String, Map<String, int>> toMap() {
    return {
      'start': _dateToMap(bookingRange.start),
      'end': _dateToMap(bookingRange.end)
    };
  }

  DateTime _dateFromMap(Map<String, int> map) {
    return DateTime(
        map['year']!, map['month']!, map['day']!, map['hour']!, map['minute']!);
  }

  Map<String, int> _dateToMap(DateTime datetime) {
    return {
      'year': datetime.year,
      'month': datetime.month,
      'day': datetime.day,
      'hour': datetime.hour,
      'minute': datetime.minute
    };
  }
}
