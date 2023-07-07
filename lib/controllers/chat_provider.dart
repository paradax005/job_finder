import 'package:flutter/material.dart';
import 'package:job_finder/models/response/chat/get_chat.dart';
import 'package:job_finder/services/helpers/chat_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  String? userId;

  /// prevent if the user is typing or not
  bool _typing = false;

  /// List of online users 
  List<String> _online = [];

  List<String> get online => _online;

  set onlineUsers(List<String> newList) {
    _online = newList;
    notifyListeners();
  }

  bool get typing => _typing;

  set typingStatus(bool newState) {
    _typing = newState;
    notifyListeners();
  }

  getChats() {
    chats = ChatHelper.getConversations();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
  }

  String showTimeAgo(String timeStamp) {
    DateTime messageTime = DateTime.parse(timeStamp);
    String timeAgo = timeago.format(messageTime);

    return timeAgo;
  }
}
