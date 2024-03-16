import 'package:flutter/material.dart';

class Booking {
  final int bookingId;
  final int stadiumId;
  final int teamId;
  final int userId;
  final String start;
  final String end;

  Booking(this.bookingId, this.stadiumId, this.teamId, this.userId, this.start, this.end);

  Booking.fromMap(Map<String, dynamic> map)
    : boogtkingId = map['booking_id'],
      stadiumId = map['stadium_id'],
      teamId = map['team_id'],
      userId = map['user_id'],
      start = map['start_date_time'],
      end = map['end_date_time'];


  Map<String, dynamic> toMap() {
    return {
      'booking_id': bookingId,
      'stadium_id': stadiumId,
      'team_id': teamId,
      'user_id': userId,
      'start_date_time': start,
      'end_date_time': end
    };
  }

  @override
  String toString() => toMap().toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Booking && bookingId == other.bookingId;

  @override
  int get hashCode => bookingId + stadiumId + teamId + userId.hashCode;
}
