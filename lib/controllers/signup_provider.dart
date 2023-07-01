import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/models/request/auth/register_model.dart';
import 'package:job_finder/services/helpers/auth_helper.dart';
import 'package:job_finder/views/ui/auth/login_screen.dart';

import '../constants/app_constants.dart';

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

  final registerFormKey = GlobalKey<FormState>();

  bool validateFormAndSave() {
    final form = registerFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  signUp(RegisterRequestModel model) async {
    AuthHelper.signup(model).then((response) {
      if (response) {
        Get.off(
          () => const LoginPage(),
          transition: Transition.fade,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Sign up Failed",
          "Please Check your credentials and try again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }
}
