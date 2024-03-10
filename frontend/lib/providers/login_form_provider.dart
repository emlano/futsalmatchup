import 'package:flutter/material.dart';

class LoginFormProvider with ChangeNotifier {
  String? _name;
  String? _password;
  String? _phoneNo;
  String? _userfieldError;
  String? _passfieldError;
  String? _phonefieldError;

  String? get phoneNo => _phoneNo;
  String? get name => _name;
  String? get password => _password;
  String? get userFieldError => _userfieldError;
  String? get passFieldError => _passfieldError;
  String? get phoneFieldError => _phonefieldError;



  void setPhoneNo(String val) {
    _phoneNo = val;
    notifyListeners();
  }

  void setName(String val) {
    _name = val;
    notifyListeners();
  }

  void setPassword(String val) {
    _password = val;
    notifyListeners();
  }

void setErrors(String? user, String? pass, String? phone) {
    _userfieldError = user;
    _passfieldError = pass;
    _phonefieldError = phone;
}

  void removeError() {
    _userfieldError = null;
    _passfieldError = null;
    _phonefieldError = null;
  }

  bool validateName() {
    if (_name == null || _name!.isEmpty) {
      _userfieldError = "Field cannot be empty!";
      return false;
    }

    if (_name!.length < 3) {
      _userfieldError = "Min length for field is 3!";
      return false;
    }

    if (_name!.length > 15) {
      _userfieldError = "Max length for field is 15!";
      return false;
    }

    return true;
  }

  bool validatePass() {
    if (_password == null || _password!.isEmpty) {
      _passfieldError = "Field cannot be empty!";
      return false;
    }

    if (_password!.length < 8) {
      _passfieldError = "Minimum length for field is 8!";
      return false;
    }

    if (_password!.length > 15) {
      _passfieldError = "Maximum length for field is 15!";
      return false;
    }

    return true;
  }

  bool validatePhone(String? phone) {
    if (_phoneNo == null || _phoneNo!.isEmpty) {
      _passfieldError = "Field cannot be empty!";
      return false;
    }

    if (_phoneNo!.length != 10) {
      _passfieldError = "Phone number must be of length 10!";
      return false;
    }

    return true;
  }
}


