import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/models/request/auth/update_profile_model.dart';
import 'package:job_finder/services/helpers/auth_helper.dart';
import 'package:job_finder/views/ui/auth/update_profile.dart';
import 'package:job_finder/views/ui/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/request/auth/login_request_model.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool isObscure) {
    _obscureText = isObscure;
    notifyListeners();
  }

  /// ENTRY POINT
  bool? _entrypoint;

  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newValue) {
    _entrypoint = newValue;
    notifyListeners();
  }

  /// LOGGED IN
  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newValue) {
    _loggedIn = newValue;
    notifyListeners();
  }

  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  bool _firstTime = true;

  bool get firstTime => _firstTime;

  set firstTime(bool newValue) {
    _firstTime = newValue;
    notifyListeners();
  }

  /// Validate Form
  final loginFormKey = GlobalKey<FormState>();
  final profileFormKey = GlobalKey<FormState>();

  bool validateFormAndSave(GlobalKey<FormState> formState) {
    final form = formState.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  /// LOGIN
  userLogin(LoginRequestModel model) {
    AuthHelper.login(model).then((response) {
      if (response && firstTime) {
        Get.off(() => const PersonalDetails());
      } else if (response && !firstTime) {
        Get.off(() => const MainScreen());
      } else if (!response) {
        Get.snackbar(
          "Sign Failed",
          "Please check your credentials and try again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  /// LOGOUT
  logout() async {
    final prefs = await SharedPreferences.getInstance();

    // await prefs.remove('token');
    await prefs.setBool("loggedIn", false);
    await prefs.remove("userId");
    await prefs.remove("profile");
    _firstTime = false;
  }

  /// Update Profile
  updateProfile(ProfileUpdateRequest profile) async {
    AuthHelper.updateProfile(profile).then((response) {
      if (response) {
        Get.snackbar(
          "Profile Update",
          "Enjoy Your Search for a Job",
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: const Icon(Icons.add_alert),
        );

        Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.offAll(() => const MainScreen());
        });
      } else {
        Get.snackbar(
          "Updating Failed",
          "Please try again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }
}
