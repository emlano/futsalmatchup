import 'package:flutter/material.dart';

class StadiumDetailsPage extends StatefulWidget {
  final String stadiumName;
  final String stadiumImagePath;

  const StadiumDetailsPage({
    required this.stadiumName,
    required this.stadiumImagePath,
    Key? key,
  }) : super(key: key);

  _StadiumDetailsPageState createState() => _StadiumDetailsPageState();
}

class _StadiumDetailsPageState extends State<StadiumDetailsPage> {
  late String _selectedDay;
  late List<String> _timeSlots;

  void initState() {
    super.initState();
    _selectedDay = 'Mon';
    _timeSlots = [
      '8am - 9am',
      '9am - 10am',
      '10am - 11am',
      '11am - 12pm',
      '12pm - 1pm',
      '1pm - 2pm',
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/app_logo.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text('Futsal MatchUp'),
          ],
        ),
      ),
    );
  }
}