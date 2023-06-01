import 'package:flutter/material.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool isObscure) {
    _obscureText = isObscure;
    notifyListeners();
  }

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern = r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)";

    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }
}
