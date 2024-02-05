import 'package:flutter/material.dart';
import 'package:frontend/models/filled_button.dart';
import 'package:frontend/models/textboxes/password_input_box.dart';
import 'package:frontend/models/textboxes/text_input_box.dart';

class LoginForm extends StatefulWidget {


  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _fromKey,
        child: Column(
          children: [
            TextInputBox(
              controller: usernameController,
              name: "Username",
              desc: "Enter an username",
              icon: Icons.account_circle,
              length: 15,
            ),
            PasswordInputBox(
              controller: passwordController,
            ),
            const SizedBox(height: 15),
            FilledIconButton(
                text: "Log in",
                icon: Icons.account_circle,
                onPressed: () {
                  if (_fromKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Processing!"))
                    );
                    print("Username: ${usernameController.text}");
                    print("Password: ${passwordController.text}");
                  }
                }
            )
          ],
        )
    );
  }
}