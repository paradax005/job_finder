import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_finder/models/request/chat/create_chat.dart';
import 'package:job_finder/models/response/chat/get_chat.dart';
import 'package:job_finder/models/response/chat/initial_msg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ChatHelper {
  static var client = https.Client();

  /// Apply for a job
  static Future<List<dynamic>> apply(CreateChat model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };

    var url = Uri.https(Config.apiUrl, Config.chatsUrl);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      var chatId = initialChatFromJson(response.body).id;
      return [true, chatId];
    } else {
      return [false];
    }
  }

  /// Get Conversations
  static Future<List<GetChats>> getConversations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };

    var url = Uri.https(Config.apiUrl, Config.chatsUrl);

    var response = await client.get(url, headers: requestHeaders);

    // print(response.body);
    if (response.statusCode == 200) {
      var chatList = getChatsFromJson(response.body);
      return chatList;
    } else {
      return throw Exception("Couldn't load chats");
    }
  }
}
