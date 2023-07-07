import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_finder/models/request/messaging/send_message.dart';
import 'package:job_finder/models/response/messaging/messaging_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class MessagingHelper {
  static var client = https.Client();

  /// Send a message
  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };

    var url = Uri.https(Config.apiUrl, Config.messagingUrl);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      ReceivedMessages message =
          ReceivedMessages.fromJson(jsonDecode(response.body));

      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [true, message, responseMap];
    } else {
      return [false];
    }
  }

  /// Send a message
  static Future<List<ReceivedMessages>> getMessages(
      String chatId, int offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };

    var url = Uri.https(Config.apiUrl, "${Config.messagingUrl}/$chatId",
        {"page": offset.toString()});

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      List<ReceivedMessages> messages = receivedMessagesFromJson(response.body);
      return messages;
    } else {
      throw Exception("Failed to load messages ");
    }
  }
}
