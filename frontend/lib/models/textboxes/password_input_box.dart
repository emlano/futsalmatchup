import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordInputBox extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInputBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 100),
        controller: controller,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.password,
            size: 30,
          ),
          iconColor: Colors.teal,
          labelText: "Password",
          hintText: "Enter password",
          border: OutlineInputBorder(),
          isDense: true
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        validator: (content) {
          if (content == null || content.isEmpty) {
            return "Required field!";
          }

          if (content.length > 15) {
            return "Character length limit is 15!";
          }

          if (content.length < 8) {
            return "Minimum password length is 8!";
          }

          return null;
        },
        maxLengthEnforcement: MaxLengthEnforcement.none,
      ),
    );
  }
}