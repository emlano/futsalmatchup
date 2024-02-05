import 'package:flutter/material.dart';

class TextInputBox extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String desc;
  final IconData icon;
  final int length;

  const TextInputBox({super.key, required this.name, required this.desc, required this.icon, required this.length, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 100),
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(
              icon,
            size: 30,
          ),
          iconColor: Colors.teal,
          labelText: name,
          hintText: desc,
          border: const OutlineInputBorder(),
          isDense: true
        ),
        validator: (content) {
          if (content == null || content.isEmpty) {
            return "Required field!";
          }

          if (length < content.length) {
            return "Character length limit is $length!";
          }

          return null;
        },
      ),
    );
  }
}