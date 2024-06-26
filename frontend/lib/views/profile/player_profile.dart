import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/logic/profile/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:frontend/views/profile/player_profile.dart';
import 'package:frontend/views/stadium/stadium_availability_page.dart';
import 'package:frontend/views/team/create_team_page.dart';
import 'package:frontend/views/team/player_search_page.dart';
import 'package:frontend/views/home/Home.dart';

class PlayerProfile extends StatefulWidget {
  @override
  _PlayerProfileState createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  bool isAvailable = false; // Availability status
  bool isEditing = false; // Edit mode
  final UserRepository userRepository =
      UserRepository(); // Instantiate UserRepository

  //get the authToken using context
  String? token;

  // Text editing controllers for player information
  TextEditingController playerNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // Function to update the user profile information
  Future<void> updateUserProfile() async {
    try {
      // Prepare profile data
      final profileData = {
        'age': int.parse(ageController.text),
        'player_city': cityNameController.text,
        'phone_no': phoneNumberController.text,
        'player_availability': isAvailable,
      };
      // Update profile data using userRepository
      await userRepository.updateUserProfile(token, profileData);

      // Show Success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User profile updated successfully'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error updating user profile: $e');

      // Show Error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating user profile. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

// Function to save changes
  void saveChanges() {
    updateUserProfile();
  }

// Function to toggle edit mode
  void toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  // Function to fetch user profile data from backend
  Future<void> fetchUserProfile() async {
    try {
      // Fetch user profile data from the backend using UserRepository
      final userProfile = await userRepository.getUserProfile(token);

      // Update text controllers with fetched user profile data
      setState(() {
        playerNameController.text = userProfile['username'];
        ageController.text =
            userProfile['age'] != null ? userProfile['age'].toString() : "0";
        cityNameController.text = userProfile['player_city'] ?? "Not set";
        phoneNumberController.text = userProfile['phone_no'] ?? "07????????";
        isAvailable = userProfile['player_availability'] == 1;
      });
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch user profile data when the widget is initialized
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    token = authProvider.token;
    fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isEditing
                                    ? TextFormField(
                                        readOnly: true,
                                        initialValue: playerNameController.text,
                                      )
                                    : Text(
                                        playerNameController.text,
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                SizedBox(height: 10),

                                // Star Rating
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 24.0),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 24.0),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 24.0),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 24.0),
                                    Icon(Icons.star_border,
                                        color: Colors.amber, size: 24.0),
                                  ],
                                ),
                                // Age
                                isEditing
                                    ? TextFormField(
                                        initialValue: ageController.text,
                                        onChanged: (value) =>
                                            {ageController.text = value},
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          hintText: 'Enter age',
                                        ),
                                      )
                                    : Text(
                                        '${ageController.text} years',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                // City
                                isEditing
                                    ? TextFormField(
                                        initialValue: cityNameController.text,
                                        onChanged: (value) =>
                                            {cityNameController.text = value},
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          hintText: 'Enter City',
                                        ),
                                      )
                                    : Text(
                                        '${cityNameController.text}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                // Phone number
                                isEditing
                                    ? TextFormField(
                                        controller: phoneNumberController,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          hintText: 'Phone number',
                                        ),
                                      )
                                    : Text(
                                        'Phone Number: ${phoneNumberController.text}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                SizedBox(height: 10),

                                Row(
                                  children: [
                                    // Player jersey image and position
                                    Image.asset('assets/images/jersey.png',
                                        width: 35, height: 35),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Pivot',
                                            style: TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Player Profile Image
                          SizedBox(width: 20),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.teal,
                                width: 2.0,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 63,
                              backgroundImage:
                                  AssetImage('assets/images/profileImage.jpg'),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 1),

                      // Update Availability Status
                      Row(
                        children: [
                          Text(
                            'Update Status',
                            style: TextStyle(fontSize: 16),
                          ),

                          SizedBox(width: 10),

                          // Switch
                          Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              value: isAvailable,
                              onChanged: (value) {
                                setState(() {
                                  isAvailable = value;
                                });
                              },
                              activeTrackColor: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      // Edit/Save Button
                      OutlinedButton(
                        onPressed: () {
                          if (!isEditing) {
                            toggleEditMode();
                          } else {
                            saveChanges();
                            toggleEditMode();
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.teal, width: 2.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isEditing ? 'Save' : 'Edit',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // First Card: Games
                            Expanded(
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Games',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '8',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Second Card: Goals
                            Expanded(
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Goals',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '15',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            // Third Card: Minutes Played
                            Expanded(
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Minutes Played',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '58%',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Fourth Card: Shots on Target
                            Expanded(
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shots on Target',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '20',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: Text(
                            'Player Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
