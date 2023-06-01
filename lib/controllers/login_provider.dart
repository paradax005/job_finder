import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool isObscure) {
    _obscureText = isObscure;
    notifyListeners();
  }
}
