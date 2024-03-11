import 'package:flutter/material.dart';

class TextInputBox extends StatelessWidget {
  final String name;
  final String desc;
  final IconData icon;
  final int length;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const TextInputBox({super.key, required this.name, required this.desc, required this.icon, required this.length, this.onChanged, this.validator});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 100),
        onChanged: onChanged,
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
        validator: validator,
      ),
    );
  }
}