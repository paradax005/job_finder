import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_finder/models/request/auth/login_request_model.dart';
import 'package:job_finder/models/request/auth/register_model.dart';
import 'package:job_finder/models/response/auth/profile_response.dart';
import 'package:job_finder/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/auth/update_profile_model.dart';
import '../../models/response/auth/login_response_model.dart';

class AuthHelper {
  static var client = https.Client();

  /// LOGIN API
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    var url = Uri.https(Config.apiUrl, Config.loginUrl);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String userToken = loginResponseModelFromJson(response.body).userToken;
      String userId = loginResponseModelFromJson(response.body).id;
      String profile = loginResponseModelFromJson(response.body).profile;

      await prefs.setString("token", userToken);
      await prefs.setString("userId", userId);
      await prefs.setString("profile", profile);
      await prefs.setBool("loggedIn", true);
      return true;
    } else {
      return false;
    }
  }

  /// REGISTER API
  static Future<bool> signup(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    var url = Uri.https(Config.apiUrl, Config.signUpUrl);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  /// UPDATE PROFILE
  static Future<bool> updateProfile(ProfileUpdateRequest model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);

    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    print(response);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// GET PROFILE
  static Future<ProfileResponse> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var profile = profileResponseFromJson(response.body);
      return profile;
    } else {
      throw Exception('Failed to get profile');
    }
  }
}
