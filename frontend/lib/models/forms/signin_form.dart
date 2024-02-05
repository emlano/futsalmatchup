import 'package:flutter/material.dart';
import 'package:frontend/models/filled_button.dart';
import 'package:frontend/models/textboxes/password_input_box.dart';
import 'package:frontend/models/textboxes//phone_input_box.dart';
import 'package:frontend/models/textboxes/text_input_box.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return SigninFormState();
  }
}

class SigninFormState extends State<SigninForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    phoneNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _fromKey,
        child: Column(
          children: [
            PhoneInputBox(
              controller: phoneNoController,
            ),
            TextInputBox(
              controller: usernameController,
              name: "Username",
              desc: "Enter your username",
              icon: Icons.account_circle,
              length: 15,
            ),
            PasswordInputBox(
              controller: passwordController,
            ),
            const SizedBox(height: 10),
            FilledIconButton(
              text: "Sign in",
              icon: Icons.group_add,
              onPressed: () {
                if (_fromKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Processing!"))
                  );
                  print("Username : ${usernameController.text}");
                  print("Password : ${passwordController.text}");
                  print("Phone no. : ${phoneNoController.text}");
                }
              }
            )
          ],
        )
    );
  }
}