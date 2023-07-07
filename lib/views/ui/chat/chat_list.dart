import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/controllers/controller.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/loader.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:job_finder/views/ui/chat/chat_page.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          title: "Chats",
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
          chatNotifier.getChats();
          chatNotifier.getPrefs();

          return FutureBuilder(
            future: chatNotifier.chats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: ReusableText(
                    text: "An Error occurred while connecting to the server",
                    style: appstyle(14, Color(kOrange.value), FontWeight.w500),
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Loader(message: "No Chats Available");
              } else {
                final chats = snapshot.data!;

                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    var user = chat.users
                        .where((user) => user.id != chatNotifier.userId);

                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ChatPage(
                              id: chat.id,
                              title: user.first.username,
                              profile: user.first.profile,
                              users: [chat.users[0].id, chat.users[1].id],
                            ),
                          );
                        },
                        child: Container(
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: Color(kLightGrey.value),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 4.w),
                            minLeadingWidth: 0,
                            minVerticalPadding: 0,
                            leading: CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage(user.first.profile),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: user.first.username,
                                  style: appstyle(
                                      16, Color(kDark.value), FontWeight.w600),
                                ),
                                const HeightSpacer(size: 5),
                                ReusableText(
                                  text: chat.latestMessage.content,
                                  style: appstyle(15, Color(kDarkGrey.value),
                                      FontWeight.normal),
                                ),
                              ],
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(right: 4.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(
                                    text: chatNotifier
                                        .showTimeAgo(chat.updatedAt.toString()),
                                    style: appstyle(12, Color(kDark.value),
                                        FontWeight.normal),
                                  ),
                                  chat.latestMessage.sender.id == user.first.id
                                      ? const Icon(
                                          Ionicons.arrow_forward_circle_outline)
                                      : const Icon(
                                          Ionicons.arrow_back_circle_outline)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
