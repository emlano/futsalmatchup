import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputBox extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const PhoneInputBox({super.key, this.onChanged, this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 100),
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
        onChanged: onChanged,
        validator: validator,
        maxLengthEnforcement: MaxLengthEnforcement.none,
      ),
    );
  }
}