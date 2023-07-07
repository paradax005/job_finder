import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_finder/controllers/chat_provider.dart';
import 'package:job_finder/models/request/messaging/send_message.dart';
import 'package:job_finder/models/response/messaging/messaging_response.dart';
import 'package:job_finder/services/helpers/messaging_helper.dart';
import 'package:job_finder/views/ui/chat/widgets/messaging_textfield.dart';
import 'package:job_finder/views/ui/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../constants/app_constants.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/reusable_text.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String id;
  final String profile;
  final List<String> users;

  const ChatPage({
    super.key,
    required this.title,
    required this.id,
    required this.profile,
    required this.users,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int offset = 1;
  IO.Socket? socket;
  late Future<List<ReceivedMessages>> msgList;
  TextEditingController messageController = TextEditingController();
  List<ReceivedMessages> messages = [];
  String receiver = "";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getMessages(offset);
    connect();
    joinChat();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void getMessages(int offset) {
    msgList = MessagingHelper.getMessages(widget.id, offset);
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          print(
              '<<<< You have reached the end of the available messages >>>>> ');
          if (messages.length >= 12) {
            getMessages(offset++);
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io(
        "https://jobfinder-backend-paradax.onrender.com/", <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket!.emit("setup", chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((_) {
      print("Connect to front end");
      socket!.on('online-user', (userId) {
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
      });

      socket!.on("typing", (status) {
        chatNotifier.typingStatus = true;
      });

      socket!.on("stop-typing", (status) {
        chatNotifier.typingStatus = false;
      });

      socket!.on("new message", (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessages receivedMessages =
            ReceivedMessages.fromJson(newMessageReceived);

        if (receivedMessages.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessages);
          });
        }
      });
    });
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);
    MessagingHelper.sendMessage(model).then((response) {
      var emission = response[2];
      socket!.emit('new message', emission);
      sendStopTypingEvent(widget.id);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stop-typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        receiver =
            widget.users.firstWhere((userId) => userId != chatNotifier.userId);

        getMessages(offset);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              title: !chatNotifier.typing ? widget.title : "Typing ......",
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.profile),
                      ),
                      Positioned(
                        // bottom: 0,
                        right: 3,
                        child: CircleAvatar(
                          radius: 5.r,
                          backgroundColor:
                              chatNotifier.online.contains(receiver)
                                  ? Colors.green
                                  : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const MainScreen());
                  },
                  child: const Icon(MaterialCommunityIcons.arrow_left),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<ReceivedMessages>>(
                      future: msgList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: ReusableText(
                              text:
                                  "An Error occurred while connecting to the server",
                              style: appstyle(
                                  14, Color(kOrange.value), FontWeight.w500),
                            ),
                          );
                        } else {
                          final msgList = snapshot.data;

                          messages = messages + msgList!;

                          return ListView.builder(
                            reverse: true,
                            controller: _scrollController,
                            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 12.h),
                                child: Column(
                                  children: [
                                    ReusableText(
                                      text: chatNotifier.showTimeAgo(
                                          messages[index].updatedAt.toString()),
                                      style: appstyle(
                                        12,
                                        Color(kDarkGrey.value),
                                        FontWeight.normal,
                                      ),
                                    ),
                                    ChatBubble(
                                      alignment: message.sender.id ==
                                              chatNotifier.userId
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      backGroundColor: message.sender.id ==
                                              chatNotifier.userId
                                          ? Color(kLightBlue.value)
                                          : Color(kOrange.value),
                                      elevation: 0,
                                      clipper: ChatBubbleClipper4(
                                        radius: 8,
                                        type: message.sender.id ==
                                                chatNotifier.userId
                                            ? BubbleType.sendBubble
                                            : BubbleType.receiverBubble,
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: width * .8,
                                        ),
                                        child: ReusableText(
                                          text: message.content,
                                          style: appstyle(
                                            14,
                                            Color(kLight.value),
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.h),
                    alignment: Alignment.bottomCenter,
                    child: MessagingTextField(
                      messageController: messageController,
                      onChanged: (_) {
                        sendTypingEvent(widget.id);
                      },
                      onEditingComplete: () {
                        sendMessage(
                            messageController.text, widget.id, receiver);
                      },
                      onSubmitted: (_) {
                        sendMessage(
                            messageController.text, widget.id, receiver);
                      },
                      suffixIcon: GestureDetector(
                        onTap: () {
                          String content = messageController.text;
                          sendMessage(content, widget.id, receiver);
                        },
                        child: Icon(
                          MaterialIcons.send,
                          size: 24,
                          color: Color(kDark.value),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
