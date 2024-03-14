import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';
import 'package:frontend/providers/auth_provider.dart'; // Import AuthProvider
import 'package:frontend/logic/profile/user_repository.dart';

class PlayerProfile extends StatefulWidget {
  @override
  _PlayerProfileState createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  bool isAvailable = true;
  bool isEditing = false;
  final UserRepository userRepository =
      UserRepository(); // Instantiate UserRepository
  AuthProvider authProvider = AuthProvider(); // Instantiate AuthProvider

  // Text editing controllers for player information
  TextEditingController playerNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // Function to update the user profile
  Future<void> updateUserProfile(String? token) async {
    try {
      final profileData = {
        'name': playerNameController.text,
        'age': int.parse(ageController.text),
        'city': cityNameController.text,
        'phoneNumber': phoneNumberController.text,
      };

      // Update user profile using UserRepository
      await userRepository.updateUserProfile(token, profileData);

      // Show success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User profile updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Handle any errors during the update
      print('Error updating user profile: $e');

      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating user profile. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Define saveChanges method
  void saveChanges(String? token) {
    // Save the changes to the backend
    updateUserProfile(token);
  }

  // Define toggleEditMode method
  void toggleEditMode() {
    // Toggles the editing mode
    setState(() {
      isEditing = !isEditing;
    });
  }

// Function to fetch user profile from backend
  Future<void> fetchUserProfile(String? token) async {
    try {
      // Fetch user profile data from the backend using UserRepository
      final userProfile = await userRepository.getUserProfile(token);
      // Update text controllers with fetched user profile data
      setState(() {
        playerNameController.text = userProfile['name'];
        ageController.text = userProfile['age'].toString();
        cityNameController.text = userProfile['city'];
        phoneNumberController.text = userProfile['phoneNumber'];
      });
    } catch (e) {
      // Handle any errors during fetching user profile
      print('Error fetching user profile: $e');
      // Show error message to the user or perform any other error handling actions
    }
  }

  // Text controllers i nitialized with default values in the initState method
  @override
  void initState() {
    super.initState();
    // Fetch user profile data when the widget is initialized
    fetchUserProfile(authProvider.token);

    playerNameController.text = 'Player Name';
    ageController.text = '25';
    cityNameController.text = 'City name';
    phoneNumberController.text = '123-456-7890';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(),
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
                                        controller: playerNameController,
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Enter your name',
                                          hintStyle: TextStyle(fontSize: 25),
                                        ),
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

                                isEditing
                                    ? TextFormField(
                                        controller: ageController,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          hintText: 'Enter age',
                                        ),
                                      )
                                    : Text(
                                        '${ageController.text} years | ${cityNameController.text}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                isEditing
                                    ? TextFormField(
                                        controller: phoneNumberController,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          hintText: 'Phone number',
                                        ),
                                      )
                                    : Text(
                                        'Phone Number:  ${phoneNumberController.text}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                SizedBox(height: 10),

                                Row(
                                  children: [
                                    // Player jersey image
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

                      // Update Status
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
                      OutlinedButton(
                        onPressed: isEditing
                            ? toggleEditMode
                            : () => saveChanges(authProvider.token),
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
