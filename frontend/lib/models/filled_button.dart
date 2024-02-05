import 'package:flutter/material.dart';
import 'package:frontend/models/inter_text.dart';

class FilledIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const FilledIconButton({super.key, required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            shadowColor: Colors.pink
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              InterText(
                  text: text,
                  size: 14,
                  color: Colors.white,
                  weight: FontWeight.bold
              )
            ],
          )
      ),
    );
  }

}