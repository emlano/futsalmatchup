import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SuccessfulPage extends StatefulWidget {
  @override
  _SuccessfulPageState createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  // Variable to hold the rating value
  double rating = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.teal,
        // Back button
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 35,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigate back to the previous page when pressed
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animation for the rating bar
            TweenAnimationBuilder(
              duration: Duration(seconds: 1),
              tween: Tween<double>(begin: 0, end: rating),
              builder: (context, double value, child) {
                return RatingBar.builder(
                  initialRating: value,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 50,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {},
                );
              },
              // Callback when the animation ends
              onEnd: () {
                // Reset the rating after a delay
                Future.delayed(Duration(milliseconds: 500), () {
                  setState(() {
                    rating = 5.0;
                  });
                });
              },
            ),
            SizedBox(height: 20),
            // Animation for the success message
            TweenAnimationBuilder(
              duration: Duration(seconds: 1),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Column(
                    children: [
                      // Success message text
                      Text(
                        'Rating Successfully',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Submitted!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
              onEnd: () {},
            ),
          ],
        ),
      ),
    );
  }
}
