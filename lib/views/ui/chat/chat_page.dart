import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/controllers/controller.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/loader.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

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
                var data = snapshot.data!;
        
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 20.h,
                      color: Colors.blue,
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
