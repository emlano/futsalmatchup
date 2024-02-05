import 'package:flutter/cupertino.dart';

class InterText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  const InterText({super.key, required this.text, required this.size, required this.color, required this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Inter',
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),

    );
  }

}