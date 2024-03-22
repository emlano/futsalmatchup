import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';

class StadiumDetailsPage extends StatefulWidget {
  final String stadiumName;
  final String stadiumImagePath;

  const StadiumDetailsPage({
    required this.stadiumName,
    required this.stadiumImagePath,
    Key? key,
  }) : super(key: key);

  @override
  _StadiumDetailsPageState createState() => _StadiumDetailsPageState();
}

class _StadiumDetailsPageState extends State<StadiumDetailsPage> {
  late String _selectedDay;
  final Map<String, List<String>> _dayTimeSlots = {
    'Mon': [
      '8am - 9am', '9am - 10am', '10am - 11am',
      '11am - 12pm', '12pm - 1pm', '1pm - 2pm'
    ],
    'Tue': [
      '8am - 9am', '9am - 10am', '10am - 11am',
      '11am - 12pm', '12pm - 1pm', '1pm - 2pm'
    ],
    'Wed': [
      '8am - 9am', '9am - 10am', '10am - 11am',
      '11am - 12pm', '12pm - 1pm', '1pm - 2pm'
    ],
    'Thu': [
      '8am - 9am', '9am - 10am', '10am - 11am',
      '11am - 12pm', '12pm - 1pm', '1pm - 2pm'
    ],
    'Fri': [
      '8am - 9am', '9am - 10am', '10am - 11am',
      '11am - 12pm', '12pm - 1pm', '1pm - 2pm'
    ],
    'Sat': [
      '8am - 9am', '9am - 10am', '10am - 11am',
      '11am - 12pm', '12pm - 1pm', '1pm - 2pm'
    ],
    'Sun': [
      '8am - 9am', '9am - 10am', '10am - 11am',
      '11am - 12pm', '12pm - 1pm', '1pm - 2pm'
    ],
  };

  late Map<String, List<bool>> _slotStatus;

  void initState() {
    super.initState();
    _selectedDay = 'Mon';
    _slotStatus = {};

    for (var day in _dayTimeSlots.keys) {
      _slotStatus[day] = List<bool>.filled(_dayTimeSlots[day]!.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.stadiumName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.stadiumImagePath,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Schedule',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Styled table
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal.shade100),
                ),
                child: Table(
                  border: TableBorder.all(color: Colors.teal.shade100),
                  children: [
                    TableRow(
                      children: [
                        _buildTableCell('Mon'),
                        _buildTableCell('Tue'),
                        _buildTableCell('Wed'),
                        _buildTableCell('Thu'),
                        _buildTableCell('Fri'),
                        _buildTableCell('Sat'),
                        _buildTableCell('Sun'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildTimeSlots(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDay = text;
        });
      },
      child: Container(
        color: _selectedDay == text ? Colors.teal : Colors.white,
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: _selectedDay == text ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTimeSlots() {
    List<String>? dayTimeSlots = _dayTimeSlots[_selectedDay];
    if (dayTimeSlots == null) return [];

    return dayTimeSlots.map((timeSlot) {
      return _buildTimeSlotButton(timeSlot);
    }).toList();
  }

  Widget _buildTimeSlotButton(String timeSlot) {
    bool isReserved = timeSlot == '9am - 10am' || timeSlot == '1pm - 2pm';
    int index = _dayTimeSlots[_selectedDay]!.indexOf(timeSlot);
    bool isBooked = _slotStatus[_selectedDay]![index];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            timeSlot,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          width: 180,
          child: ElevatedButton(
            onPressed: () {
            
              if (!isReserved && !isBooked) {
                setState(() {
                  _slotStatus[_selectedDay]![index] = true;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isReserved ? Colors.grey : isBooked ? Colors.red : Colors.teal.shade100,
            ),
            child: Text(
              isReserved ? 'Reserved' : isBooked ? 'Reserved' : 'Book this slot',
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}


void createBooking(String token, String teamName, BuildContext context) async {
    const url = 'http://localhost:3000/teams';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode([{'teamName': teamName}]);

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Team created succssfully');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamRosterPage(teamName: teamName),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create team. Please try again.'),
          ),
        );
      }
    } catch (error) {
      // Handle errors
      print('Error creating team: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }
}
