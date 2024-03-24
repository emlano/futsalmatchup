import 'package:flutter/material.dart';
import 'package:frontend/views/home/upcoming_bookings.dart';
import 'package:frontend/views/home/teams.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/views/profile/player_profile.dart';
import 'package:frontend/views/stadium/stadium_availability_page.dart';
import 'package:frontend/views/team/create_team_page.dart';
import 'package:frontend/views/team/player_search_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<upcoming_bookings> bookings = [
  upcoming_bookings(
      "Unique Warriors vs Spacers", "CRFC kalubowila", "8.00-9.00"),
  upcoming_bookings("Lions vs Tigers", "Uni-Sports Kirulapone", "11.00-12.00"),
  upcoming_bookings("FCK A vs FCK B", "Turf Wellawatta", "13.00-15.00"),
];
List<teams> teamss = [
  teams("Sky Riders", "6-A side", ""),
  teams("Team Crisis", "5-A Side", ""),
  teams("IITIANS", "5-A Side", "")
];

Widget historyTemplate(teams items) {
  return Container(
    height: 205,
    width: 205,
    child: Card(
      elevation: 4.0,
      color: Colors.grey[450],
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            "assets/images/futsallogo1.jpg",
            fit: BoxFit.cover,
            height: 129,
            width: 200,
          ),
        ),
        Text(items.team,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        Text(
          items.playerCount,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        RatingBar.builder(
          initialRating: 3.5,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            // Handle the updated rating if needed
          },
        ),
      ]),
    ),
  );
}

Widget bookingTemplate(upcoming_bookings item) {
  return Container(
    height: 250,
    width: 300,
    child: Card(
      elevation: 4.0,
      color: Colors.grey[450],
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                "assets/images/Futsal1.jpg",
                fit: BoxFit.cover,
                height: 129,
                width: 275,
              ),
            ),
            Text(item.teams,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            Text(
              item.location,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Text(
              item.time,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your onPressed logic here
              },
              child: Text('Check Booking'),
            )
          ],
        ),
      ),
    ),
  );
}

class _HomeState extends State<Home> {

  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Futsal MatchUp",
          style: TextStyle(
            fontFamily: 'DancingScript',
            fontWeight: FontWeight.bold,
            fontSize: 34,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sports_soccer, size: 27),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Menu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'inter',
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.grey,
                    size: 27,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Home'),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home()));
              },
            ),

            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('User Profile'),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PlayerProfile()));
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.stadium,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Book a Stadium'),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StadiumPage()));
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.add_box_sharp,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Create a Team'),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateTeamPage()));
              },
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Search Players'),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerSearchPage()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              child: Text("UPCOMING BOOKINGS",
                  style: TextStyle(
                    fontFamily: "inter",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    bookings.map((item) => bookingTemplate(item)).toList(),
              ),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              child: Text(
                "YOUR TEAMS",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: "inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    teamss.map((items) => historyTemplate(items)).toList(),
              ),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              child: Text(
                "INVITES",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.grey[200],
                    ),
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player 465 invited you",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add logic for accepting the request
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    Colors.green[200], // Set the button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text('Accept'),
                            ),
                            // Add some spacing between buttons
                            OutlinedButton(
                              onPressed: () {
                                // Add logic for declining the request
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                // Set the button border color
                                side: BorderSide(color: Colors.red),
                                // Set the button border
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text('Decline'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.grey[200],
                    ),
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player 112 invited you",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add logic for accepting the request
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    Colors.green[200], // Set the button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text('Accept'),
                            ),
                            // Add some spacing between buttons
                            OutlinedButton(
                              onPressed: () {
                                // Add logic for declining the request
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                // Set the button border color
                                side: BorderSide(color: Colors.red),
                                // Set the button border
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text('Decline'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.grey[200],
                    ),
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Player 220 invited you",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add logic for accepting the request
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    Colors.green[200], // Set the button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text('Accept'),
                            ),
                            // Add some spacing between buttons
                            OutlinedButton(
                              onPressed: () {
                                // Add logic for declining the request
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                // Set the button border color
                                side: BorderSide(color: Colors.red),
                                // Set the button border
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text('Decline'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//Function to create the booked
// Future<List<Booked>> getBooked() async {
//   final response = await http.get(
//     Uri.parse(''http://localhost:3000/Booked'),
//     headers: {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $token',
//     },
//   );
//
//   if (response.statusCode == 200) {
//     final List<dynamic> jsonList = jsonDecode(response.body);
//     final List<Booked> bookedList =
//     jsonList.map((json) => Booked.fromJson(json)).toList();
//     return bookedList;
//   } else {
//     throw Exception('Failed to load booked list');
//   }
// }
