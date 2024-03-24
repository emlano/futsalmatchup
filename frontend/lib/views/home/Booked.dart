
class Booked {
  final int bookingId;
  final String stadiumName;
  final String team;
  final String times;

  Booked({
    required this.bookingId,
    required this.stadiumName,
    required this.team,
    required this.times,
  });

  factory Booked.fromJson(Map<String, dynamic> json) {
    return Booked(
      bookingId: json['Booking_id'] as int,
      stadiumName: json['stadium_name'] as String,
      team: json['team'] as String,
      times: json['times'] as String,
    );
  }
}