import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputBox extends StatelessWidget {
  final TextEditingController controller;

  const PhoneInputBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 100),
        controller: controller,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.phone,
            size: 30,
          ),
          iconColor: Colors.teal,
          labelText: "Phone number",
          hintText: "07X XXX XXXX",
          border: OutlineInputBorder(),
          isDense: true
        ),
        keyboardType: TextInputType.phone,
        validator: (content) {
          if (content == null || content.isEmpty) {
            return "Required field!";
          }

          if (content.contains(RegExp(r'^[0-9]+$')) == false) {
            return "Only numbers can be entered!";
          }

          if (10 != content.length) {
            return "Must contain 10 digits!";
          }

          if (content.startsWith(RegExp('07')) == false) {
            return "Must start with '07'!";
          }

          return null;
        },
        maxLengthEnforcement: MaxLengthEnforcement.none,
      ),
    );
  }
}