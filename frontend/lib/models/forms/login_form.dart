import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/errors/bad_request.dart';
import 'package:frontend/errors/login_info_incorrect.dart';
import 'package:frontend/errors/server_error.dart';
import 'package:frontend/errors/user_not_found.dart';
import 'package:frontend/models/filled_button.dart';
import 'package:frontend/models/textboxes/password_input_box.dart';
import 'package:frontend/models/textboxes/text_input_box.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/login_form_provider.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../api/users_api.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: _formKey,
        child: Column(
          children: [
            TextInputBox(
              name: "Username",
              desc: "Enter username",
              icon: Icons.account_circle,
              onChanged: (value) => loginProvider.setName(value),
              validator: (value) => loginProvider.userFieldError,
              length: 15,
            ),
            PasswordInputBox(
              onChanged: (value) => loginProvider.setPassword(value),
              validator: (value) => loginProvider.passFieldError
            ),
            const SizedBox(height: 15),
            FilledIconButton(
                text: "Log in",
                icon: Icons.account_circle,
                onPressed: () async {
                  loginProvider.removeError();

                  loginProvider.validateName();
                  loginProvider.validatePass();
                  
                  if (loginProvider.userFieldError == null && loginProvider.passFieldError == null) {
                    try {
                      String token = await getUserToken(
                          loginProvider.name!, loginProvider.password!);
                      authProvider.setToken(token);
                      Navigator.pushNamed(context, "/home");
                    } catch (e) {
                      if (e is BadLoginInfoException) {
                        const String err = "Username or password was wrong!";
                        loginProvider.setErrors(err, err, null);
                      }

                      if (e is UserNotFoundException) {
                        const String err = "No such user found!";
                        loginProvider.setErrors(err, err, null);
                      }

                      if (e is BadRequestException) {
                        const String err = "Bad request!";
                        loginProvider.setErrors(err, err, null);
                      }

                      if (e is ServerErrorException) {
                        const String err = "Internal server error!";
                        loginProvider.setErrors(err, err, null);
                      }
                    }
                  }

                  _formKey.currentState!.validate();
                })
          ],
        ));
  }
}
