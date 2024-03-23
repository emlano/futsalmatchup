import 'package:flutter/material.dart';
import 'package:frontend/models/header_app_bar.dart';

// StatefulWidget to manage stateful behavior
class StadiumDetailsPage extends StatefulWidget {
  final String stadiumName;
  final String stadiumImagePath;

  // Constructor for the StadiumDetailsPage
  const StadiumDetailsPage({
    required this.stadiumName,
    required this.stadiumImagePath,
    Key? key,
  }) : super(key: key);

  @override
  _StadiumDetailsPageState createState() => _StadiumDetailsPageState(); // Creating state for the StadiumDetailsPage
}

class _StadiumDetailsPageState extends State<StadiumDetailsPage> {
  late String _selectedDay;
  final Map<String, List<String>> _dayTimeSlots = { // Map containing day-wise time slots
    'Mon': [
      '8am - 9am',
      '9am - 10am',
      '10am - 11am',
      '11am - 12pm',
      '12pm - 1pm',
      '1pm - 2pm'
    ],
    'Tue': [
      '8am - 9am',
      '9am - 10am',
      '10am - 11am',
      '11am - 12pm',
      '12pm - 1pm',
      '1pm - 2pm'
    ],
    'Wed': [
      '8am - 9am',
      '9am - 10am',
      '10am - 11am',
      '11am - 12pm',
      '12pm - 1pm',
      '1pm - 2pm'
    ],
    'Thu': [
      '8am - 9am',
      '9am - 10am',
      '10am - 11am',
      '11am - 12pm',
      '12pm - 1pm',
      '1pm - 2pm'
    ],
    'Fri': [
      '8am - 9am',
      '9am - 10am',
      '10am - 11am',
      '11am - 12pm',
      '12pm - 1pm',
      '1pm - 2pm'
    ],
    'Sat': [
      '8am - 9am',
      '9am - 10am',
      '10am - 11am',
      '11am - 12pm',
      '12pm - 1pm',
      '1pm - 2pm'
    ],
    'Sun': [
      '8am - 9am',
      '9am - 10am',
      '10am - 11am',
      '11am - 12pm',
      '12pm - 1pm',
      '1pm - 2pm'
    ],
  };

  late Map<String, List<bool>> _slotStatus; // Status of each time slot

  void initState() {
    super.initState();
    _selectedDay = 'Mon';
    _slotStatus = {}; // Initializing slot status map

    // Initializing slot status for each day
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
                  widget.stadiumName, // Displaying stadium name
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
                    widget.stadiumImagePath, // Displaying stadium image
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Schedule', // Displaying schedule header
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Styled table to display days
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal.shade100),
                ),
                child: Table(
                  border: TableBorder.all(color: Colors.teal.shade100),
                  children: [
                    TableRow(
                      children: [
                        _buildTableCell('Mon'), // Building table cell for each day
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
                children: _buildTimeSlots(), // Building time slots for the selected day
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build table cell for a day
  Widget _buildTableCell(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDay = text; // Updating selected day on tap
        });
      },
      child: Container(
        color: _selectedDay == text ? Colors.teal : Colors.white, // Highlighting selected day
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

  // Method to build time slots for the selected day
  List<Widget> _buildTimeSlots() {
    List<String>? dayTimeSlots = _dayTimeSlots[_selectedDay];
    if (dayTimeSlots == null) return [];

    return dayTimeSlots.map((timeSlot) {
      return _buildTimeSlotButton(timeSlot); // Building time slot button for each time slot
    }).toList();
  }

  // Widget to build time slot button
  Widget _buildTimeSlotButton(String timeSlot) {
    bool isReserved = timeSlot == '9am - 10am' || timeSlot == '1pm - 2pm'; // Checking if the time slot is reserved
    int index = _dayTimeSlots[_selectedDay]!.indexOf(timeSlot);
    bool isBooked = _slotStatus[_selectedDay]![index]; // Checking if the time slot is booked

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            timeSlot, // Displaying time slot
            style: const TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          width: 180,
          child: ElevatedButton(
            onPressed: () {

              if (!isReserved && !isBooked) { // Allowing booking if the slot is not reserved or booked
            
         
                setState(() {
                  _slotStatus[_selectedDay]![index] = true; // Updating slot status
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isReserved
                  ? Colors.grey // Grey background if the slot is reserved
                  : isBooked
                      ? Colors.red // Red background if the slot is booked
                      : Colors.teal.shade100, // Teal background if the slot is available
            ),
            child: Text(
              isReserved
                  ? 'Reserved' // Displaying 'Reserved' if the slot is reserved
                  : isBooked
                      ? 'Reserved' // Displaying 'Reserved' if the slot is booked
                      : 'Book this slot', // Displaying 'Book this slot' if the slot is available
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

