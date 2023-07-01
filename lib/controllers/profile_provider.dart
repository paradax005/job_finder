import 'package:flutter/material.dart';
import 'package:job_finder/models/response/auth/profile_response.dart';
import 'package:job_finder/services/helpers/auth_helper.dart';

class ProfileNotifier extends ChangeNotifier {
  Future<ProfileResponse>? profile; 
  getProfile() async {
    profile = AuthHelper.getProfile();
  }
}
