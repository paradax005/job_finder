import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_finder/models/request/bookmark/bookmark_req.dart';
import 'package:job_finder/models/response/bookmark/all_bookmark.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/bookmark/bookmark.dart';
import '../config.dart';

class BookMarkHelper {
  static var client = https.Client();

  /// ADD BookMark
  static Future<List<dynamic>> addBookMarks(BookmarkRequest bookmark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(bookmark));

    if (response.statusCode == 201) {
      String bookmarkId = bookMarkResFromJson(response.body).id;
      return [true, bookmarkId];
    } else {
      return [false];
    }
  }

  /// DELETE BookMark
  static Future<bool> deleteBookMarks(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };

    var url = Uri.https(Config.apiUrl, "${Config.bookmarkUrl}/$jobId");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// GET ALL BookMarks
  static Future<List<AllBookMarkRes>> getAllBookMarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token",
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      List<AllBookMarkRes> bookmarksList =
          allBookMarkResFromJson(response.body);
      return bookmarksList;
    } else {
      throw Exception('Failed to fetch available jobs');
    }
  }
}
