import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/controllers/controller.dart';
import 'package:job_finder/controllers/jobs_provider.dart';
import 'package:job_finder/models/request/bookmark/bookmark_req.dart';
import 'package:job_finder/views/common/app_bar.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/custom_outline_button.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

class JobPage extends StatefulWidget {
  final String id;
  final String title;

  const JobPage({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobNotifier, child) {
        jobNotifier.getJob(widget.id);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              title: widget.title,
              actions: [
                Consumer<BookMarkNotifier>(
                    builder: (context, bookmarkNotifier, child) {
                  return InkWell(
                    onTap: () {
                      if (bookmarkNotifier.jobs.contains(widget.id)) {
                        bookmarkNotifier.deleteBookMark(widget.id);
                      } else {
                        BookmarkRequest bookmark =
                            BookmarkRequest(job: widget.id);
                        bookmarkNotifier.addBookMark(bookmark, widget.id);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: !bookmarkNotifier.jobs.contains(widget.id)
                          ? const Icon(Fontisto.bookmark)
                          : const Icon(Fontisto.bookmark_alt),
                    ),
                  );
                }),
              ],
              child: InkWell(
                onTap: () => Get.back(),
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: FutureBuilder(
              future: jobNotifier.jobDetail,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  var job = snapshot.data;
                  return Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const HeightSpacer(size: 30),
                          Container(
                            width: width,
                            height: height * .27,
                            color: Color(kLightGrey.value),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(job!.imageUrl),
                                ),
                                const HeightSpacer(size: 10),
                                ReusableText(
                                  text: job.title,
                                  style: appstyle(
                                      22, Color(kDark.value), FontWeight.w600),
                                ),
                                const HeightSpacer(size: 5),
                                ReusableText(
                                  text: job.location,
                                  style: appstyle(16, Color(kDarkGrey.value),
                                      FontWeight.normal),
                                ),
                                const HeightSpacer(size: 15),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomOutlineButton(
                                        width: width * .26,
                                        height: height * .04,
                                        text: job.period,
                                        mainColor: Color(kOrange.value),
                                        outlineColor: Color(kLight.value),
                                      ),
                                      Row(
                                        children: [
                                          ReusableText(
                                            text: job.salary,
                                            style: appstyle(
                                              20,
                                              Color(kDark.value),
                                              FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            // width: width * .26,
                                            child: ReusableText(
                                              text: "/monthly",
                                              style: appstyle(
                                                18,
                                                Color(kDark.value),
                                                FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          ReusableText(
                            text: "Job Descriptions",
                            style: appstyle(
                              22,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Text(
                            job.description,
                            textAlign: TextAlign.justify,
                            maxLines: 8,
                            style: appstyle(
                              16,
                              Color(kDarkGrey.value),
                              FontWeight.normal,
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          ReusableText(
                            text: "Requirements",
                            style: appstyle(
                              22,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          SizedBox(
                            height: height * 0.6,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: job.requirements.length,
                              itemBuilder: (context, index) {
                                String bullet = "\u2022";
                                return Text(
                                  "$bullet ${job.requirements[index]}",
                                  textAlign: TextAlign.justify,
                                  style: appstyle(
                                    16,
                                    Color(kDarkGrey.value),
                                    FontWeight.normal,
                                  ),
                                );
                              },
                            ),
                          ),
                          const HeightSpacer(size: 20),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CustomOutlineButton(
                            onTap: () {},
                            width: width,
                            height: height * .06,
                            text: "Apply Now",
                            mainColor: Color(kLight.value),
                            outlineColor: Color(kOrange.value),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
