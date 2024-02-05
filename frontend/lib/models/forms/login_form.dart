import 'package:flutter/material.dart';
import 'package:frontend/models/filled_button.dart';
import 'package:frontend/models/textboxes/password_input_box.dart';
import 'package:frontend/models/textboxes/phone_input_box.dart';
import 'package:frontend/models/textboxes/text_input_box.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _fromKey,
        child: Column(
          children: [
            const TextInputBox(
              name: "Username",
              desc: "Enter an username",
              icon: Icons.account_circle,
              length: 15,
            ),
            const PasswordInputBox(),
            const SizedBox(height: 15),
            FilledIconButton(
                text: "Log in",
                icon: Icons.account_circle,
                onPressed: () {
                  if (_fromKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Processing!"))
                    );
                  }
                }
            )
          ],
        )
    );
  }
}