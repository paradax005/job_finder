import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_finder/controllers/bookmark_provider.dart';
import 'package:job_finder/controllers/controller.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/ui/jobs/widget/job_tile.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';
import '../jobs/job_page.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          title: "BookMarks",
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<BookMarkNotifier>(
        builder: (context, bookmarkNotifier, child) {
          bookmarkNotifier.fetchAllBookMarks();
          return FutureBuilder(
            future: bookmarkNotifier.bookmarks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text(
                  "Error ${snapshot.error}",
                );
              } else {
                var allBookmarks = snapshot.data;
                return allBookmarks!.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: ListView.separated(
                          itemCount: allBookmarks.length,
                          separatorBuilder: (context, index) {
                            return const HeightSpacer(size: 10);
                          },
                          itemBuilder: (context, index) {
                            var bookmark = allBookmarks[index];
                            return VerticalTileWidget(
                              job: bookmark.job,
                              onTap: () {
                                Get.to(
                                  () => JobPage(
                                      id: bookmark.job.id,
                                      title: bookmark.job.company),
                                );
                              },
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text("You haven't already created any bookmark"),
                      );
              }
            },
          );
        },
      ),
    );
  }
}
