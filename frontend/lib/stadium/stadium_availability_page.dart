import 'package:flutter/material.dart';
import 'stadium_details_page.dart';

class StadiumAvailabilityPage extends StatefulWidget {
  const StadiumAvailabilityPage({Key? key}) : super(key: key);

  _StadiumAvailabilityPageState createState() => _StadiumAvailabilityPageState();
}

class _StadiumAvailabilityPageState extends State<StadiumAvailabilityPage> {
  List<String> stadiums = [
    'CR7 Futsal & Indoor Cricket Court',
    'Colombo Futsal Club',
    'Uni Sports Center - Alfred House',
    'Club Fusion Boralesgamuwa',
  ];

  Map<String, String> stadiumImagePaths = {
    'CR7 Futsal & Indoor Cricket Court': 'assets/stadium1.png',
    'Colombo Futsal Club': 'assets/stadium2.png',
    'Uni Sports Center - Alfred House': 'assets/stadium3.png',
    'Club Fusion Boralesgamuwa': 'assets/stadium4.png',
  };

  List<String> filteredStadiums = [];

  void initState() {
    super.initState();
    filteredStadiums.addAll(stadiums);
  }

  void filterStadiums(String query) {
    setState(() {
      filteredStadiums = stadiums
          .where((stadium) =>
          stadium.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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