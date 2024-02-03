import 'package:flutter/material.dart';
import 'team_roster_page.dart';

void main() { //for testing
  runApp(const MaterialApp(home: CreateTeamPage()));
}

class CreateTeamPage extends StatelessWidget {
  const CreateTeamPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    String? teamName;

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
            const Text("Futsal MatchUp"),
          ],
        ),
      ),
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
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Add Team Logo',
                      style: TextStyle(
                        fontSize: 16,
                      )
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) {
                        teamName = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your Team Name',
                        border: OutlineInputBorder()
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
                      backgroundColor: Colors.teal.shade100, // Light teal background color
                      ),
                      child: const Text(
                      'Create Team',
                      style: TextStyle(color: Colors.black), // Black font color
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