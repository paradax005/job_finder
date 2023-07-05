import 'package:flutter/material.dart';
import 'package:job_finder/models/response/chat/get_chat.dart';
import 'package:job_finder/services/helpers/chat_helper.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;

  getChats() {
    chats = ChatHelper.getConversations();
  }
}
