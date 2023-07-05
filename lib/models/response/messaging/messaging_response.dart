import 'dart:convert';

List<ReceivedMessages> receivedMessagesFromJson(String str) =>
    List<ReceivedMessages>.from(
        json.decode(str).map((x) => ReceivedMessages.fromJson(x)));

class ReceivedMessages {
  final String id;
  final Sender sender;
  final String content;
  final Chat chat;
  final List<dynamic> readBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ReceivedMessages({
    required this.id,
    required this.sender,
    required this.content,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ReceivedMessages.fromJson(Map<String, dynamic> json) =>
      ReceivedMessages(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        chat: Chat.fromJson(json["chat"]),
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Chat {
  final String id;
  final String chatName;
  final bool isGroup;
  final List<User> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String latestMessage;

  Chat({
    required this.id,
    required this.chatName,
    required this.isGroup,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        chatName: json["chatName"],
        isGroup: json["isGroup"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: json["latestMessage"],
      );
}

class User {
  final String id;
  final String username;
  final String email;
  final String profile;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profile": profile,
      };
}

class Sender {
  final String id;
  final String username;
  final String email;
  final String profile;

  Sender({
    required this.id,
    required this.username,
    required this.email,
    required this.profile,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profile: json["profile"],
      );
}
