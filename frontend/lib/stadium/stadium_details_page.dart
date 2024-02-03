import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: StadiumDetailsPage(
      stadiumName: 'CR7 Futsal & Indoor Cricket Court',
      stadiumImagePath: 'assets/stadium1.png',
    ),
  ));
}

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
  late List<String> _timeSlots;

  @override
  void initState() {
    super.initState();
    _selectedDay = 'Mon';
    _timeSlots = [
      '8am - 9am',
      '9am - 10am',
      '10am - 11am',
      '11am - 12pm',
      '12pm - 1pm',
      '1pm - 2pm',
    ];
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
              const Text(
                'Schedule',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
    return _timeSlots.map((timeSlot) {
      return _buildTimeSlotButton(timeSlot);
    }).toList();
  }

  Widget _buildTimeSlotButton(String timeSlot) {
    bool isReserved = timeSlot == '9am - 10am' || timeSlot == '1pm - 2pm';
    bool isBooked = false;

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
                  isBooked = true;
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