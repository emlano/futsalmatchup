import 'package:flutter/material.dart';
import 'package:frontend/api/users_api.dart';
import 'package:frontend/errors/bad_request.dart';
import 'package:frontend/errors/server_error.dart';
import 'package:frontend/errors/username_taken.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
        key: _formKey,
        child: Column(
          children: [
            PhoneInputBox(
              onChanged: (value) => loginProvider.setPhoneNo(value),
              validator: (value) => loginProvider.phoneFieldError,
            ),
            TextInputBox(
              name: "Username",
              desc: "Enter your username",
              icon: Icons.account_circle,
              length: 15,
              onChanged: (value) => loginProvider.setName(value),
              validator: (value) => loginProvider.userFieldError,
            ),
            PasswordInputBox(
              onChanged: (value) => loginProvider.setPassword(value),
              validator: (value) => loginProvider.passFieldError,
            ),
            const SizedBox(height: 10),
            FilledIconButton(
                text: "Sign in",
                icon: Icons.group_add,
                onPressed: () async {
                  loginProvider.removeError();

                  loginProvider.validatePhone();
                  loginProvider.validateName();
                  loginProvider.validatePass();

                  if (loginProvider.phoneFieldError == null &&
                      loginProvider.userFieldError == null &&
                      loginProvider.passFieldError == null) {
                    try {
                      String token = await getUserTokenWhenSignup(
                          loginProvider.name!,
                          loginProvider.password!,
                          loginProvider.phoneNo!);

                      authProvider.setToken(token);
                      Navigator.pushNamed(context, '/profile');
                    } catch (e) {
                      if (e is BadRequestException) {
                        const String err = "Bad request!";
                        loginProvider.setErrors(err, err, err);
                      }

                      if (e is UsernameAlreadyTaken) {
                        const String err = "Username already taken!";
                        loginProvider.setErrors(err, null, null);
                      }

                      if (e is ServerErrorException) {
                        const String err = "Internal server error!";
                        loginProvider.setErrors(err, err, err);
                      }
                    }
                  }

                  _formKey.currentState!.validate();
                })
          ],
        ));
  }
}
