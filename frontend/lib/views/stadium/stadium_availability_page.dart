import 'package:flutter/material.dart';
import 'stadium_details_page.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:frontend/models/textboxes/text_input_box.dart';

void main() {
  runApp(const StadiumPage());
}

class StadiumPage extends StatelessWidget {
  const StadiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stadium Availability',
      home: StadiumAvailabilityPage(),
    );
  }
}

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
    'CR7 Futsal & Indoor Cricket Court': 'assets/images/stadium_icon.png',
    'Colombo Futsal Club': 'assets/images/stadium_icon.png',
    'Uni Sports Center - Alfred House': 'assets/images/stadium_icon.png',
    'Club Fusion Boralesgamuwa': 'assets/images/stadium_icon.png',
  };

  List<String> filteredStadiums = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredStadiums.addAll(stadiums);
  }

  void filterStadiums(String query) {
    setState(() {
      filteredStadiums = stadiums
          .where((stadium) => stadium.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Select a Stadium',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextInputBox(
              controller: searchController,
              name: "Stadium",
              desc: "Enter stadium name",
              icon: Icons.stadium,
              length: 20,
              onChanged: filterStadiums,
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