import 'package:flutter/material.dart';
import 'package:frontend/models/filled_button.dart';
import 'package:frontend/models/textboxes/password_input_box.dart';
import 'package:frontend/models/textboxes//phone_input_box.dart';
import 'package:frontend/models/textboxes/text_input_box.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return SigninFormState();
  }
}

class SigninFormState extends State<SigninForm> {

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
        child: Column(
          children: [
            PhoneInputBox(
              onChanged: (value) => {
                loginProvider.setPhoneNo(value),
                loginProvider.removeError()
              },
              validator: (value) => loginProvider.userFieldError,
            ),
            TextInputBox(
              name: "Username",
              desc: "Enter your username",
              icon: Icons.account_circle,
              length: 15,
              onChanged: (value) => {
                loginProvider.setName(value),
                loginProvider.removeError()
              },
              validator: (value) => loginProvider.passFieldError,
            ),
            PasswordInputBox(
              onChanged: (value) => {
                loginProvider.setPassword(value),
                loginProvider.removeError()
              },
            ),
            const SizedBox(height: 10),
            FilledIconButton(
              text: "Sign in",
              icon: Icons.group_add,
              onPressed: () {}
            )
          ],
        )
    );
  }
}