import 'package:flutter/material.dart';
import 'stadium_details_page.dart';

class StadiumAvailabilityPage extends StatefulWidget {
  const StadiumAvailabilityPage({Key? key}) : super(key: key);

  @override
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

  @override
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

  @override
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Stadium',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: filterStadiums,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for a stadium',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredStadiums.length,
                itemBuilder: (context, index) {
                  final stadiumName = filteredStadiums[index];
                  final imagePath = stadiumImagePaths[stadiumName] ?? '';
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StadiumDetailsPage(
                            stadiumName: stadiumName,
                            stadiumImagePath: imagePath,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imagePath,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(stadiumName),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}