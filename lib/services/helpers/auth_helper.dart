import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_finder/models/request/auth/login_request_model.dart';
import 'package:job_finder/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/auth/login_response_model.dart';

class AuthHelper {
  static var client = https.Client();

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
}
