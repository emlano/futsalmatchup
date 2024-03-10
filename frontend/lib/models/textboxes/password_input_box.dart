import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordInputBox extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const PasswordInputBox({super.key, this.validator, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 100),
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
        onChanged: onChanged,
        validator: validator,
        maxLengthEnforcement: MaxLengthEnforcement.none,
      ),
    );
  }
}