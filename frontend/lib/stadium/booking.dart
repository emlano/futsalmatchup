import 'package:flutter/material.dart';

class Booking {
  late final DateTimeRange range;

  Booking(DateTime start, DateTime end) {
    range = DateTimeRange(start: start, end: end);
  }

  Booking.fromMap(Map<String, Map<String, int>> map) {
    DateTime start = _dateFromMap(map['start']!);
    DateTime end = _dateFromMap(map['end']!);

    range = DateTimeRange(start: start, end: end);
  }

  Map<String, Map<String, int>> toMap() {
    return {'start': _dateToMap(range.start), 'end': _dateToMap(range.end)};
  }

  static DateTime dateFromInts(
      int year, int month, int day, int hour, int minute) {
    return DateTime(year, month, day, hour, minute);
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

  DateTime get start => range.start;
  DateTime get end => range.end;

  bool overlaps(Booking other) {
    if (this == other) return true;
    if (start.isBefore(other.start) && end.isAfter(other.start)) return true;
    if (start.isAfter(other.end) && end.isBefore(other.end)) return true;
    return false;
  }

  @override
  String toString() => toMap().toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Booking && range == other.range;

  @override
  int get hashCode => range.hashCode;
}
