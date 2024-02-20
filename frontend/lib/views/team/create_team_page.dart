import 'package:flutter/material.dart';
import 'team_roster_page.dart';
import 'package:frontend/models/header_app_bar.dart';

void main() { //for testing
  runApp(const MaterialApp(home: CreateTeamPage()));
}

class CreateTeamPage extends StatelessWidget {
  const CreateTeamPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    String? teamName;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create Your Team',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                )
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Team Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.teal.shade100,
                          radius: 50,
                        ),
                        const Text(
                          '+',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) {
                        teamName = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your Team Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (teamName != null && teamName!.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TeamRosterPage(teamName: teamName!),
                            ),
                            );
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                            content: Text('Please enter a team name.'),
                            ),
                          );
                          }
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade100,
                      ),
                      child: const Text(
                        'Create Team',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}