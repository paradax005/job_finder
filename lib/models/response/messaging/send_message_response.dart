
import 'dart:convert';

SendMessageRes receivedMessageResFromJson(String str) => SendMessageRes.fromJson(json.decode(str));

String sendMessageResToJson(SendMessageRes data) => json.encode(data.toJson());

class SendMessageRes {
    final String id;
    final Sender sender;
    final String content;
    final String receiver;
    final Chat chat;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    SendMessageRes({
        required this.id,
        required this.sender,
        required this.content,
        required this.receiver,
        required this.chat,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory SendMessageRes.fromJson(Map<String, dynamic> json) => SendMessageRes(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: Chat.fromJson(json["chat"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "receiver": receiver,
        "chat": chat.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Chat {
    final String id;

    Chat({
        required this.id,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
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

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profile": profile,
    };
}
