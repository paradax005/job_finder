import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/controllers/jobs_provider.dart';
import 'package:job_finder/views/common/app_bar.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/drawer/drawer_widget.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/search.dart';
import 'package:job_finder/views/ui/jobs/job_page.dart';
import 'package:job_finder/views/ui/jobs/jobs_list.dart';
import 'package:job_finder/views/ui/jobs/widget/job_horizontaltile.dart';
import 'package:job_finder/views/ui/search/search_page.dart';
import 'package:provider/provider.dart';

import '../common/heading_widget.dart';
import '../common/horizontal_shimmer.dart';
import '../common/vertical_shimmer.dart';
import 'jobs/widget/job_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          title: "Home",
          actions: [
            Padding(
              padding: EdgeInsets.all(12.h),
              child: const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
            ),
          ],
          child: const DrawerWidget(),
        ),
      ),
      body: Consumer<JobsNotifier>(
        builder: (context, jobsNotifier, child) {
          jobsNotifier.getJobs();
          jobsNotifier.getRecentJob();
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpacer(size: 10),
                    Text(
                      "Search \nFind & Apply ",
                      style: appstyle(40, Color(kDark.value), FontWeight.bold),
                    ),
                    const HeightSpacer(size: 40),
                    SearchWidget(
                      onTap: () {
                        Get.to(() => const SearchPage());
                      },
                    ),
                    const HeightSpacer(size: 30),
                    HeadingWidget(
                      text: "Popular Jobs",
                      onTap: () {
                        Get.to(() => const JobsList());
                      },
                    ),
                    const HeightSpacer(size: 15),
                    SizedBox(
                      height: height * .27,
                      child: FutureBuilder(
                        future: jobsNotifier.jobsList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const HorizontalShimmer();
                          } else if (snapshot.hasError) {
                            return const Text(
                              "An Error occurred while connecting to the server",
                            );
                          } else {
                            var jobs = snapshot.data!;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: jobs.length,
                              itemBuilder: (context, index) {
                                final job = jobs[index];
                                return JobHorizontalTile(
                                  job: job,
                                  onTap: () {
                                    Get.to(
                                      () => JobPage(
                                        id: job.id,
                                        title: job.company,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    const HeightSpacer(size: 20),
                    HeadingWidget(
                      text: "Recently Posted",
                      onTap: () {},
                    ),
                    const HeightSpacer(size: 10),
                    FutureBuilder(
                      future: jobsNotifier.recentJob,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const VerticalShimmer();
                        } else if (snapshot.hasError) {
                          return const Text(
                            "An Error occurred while connecting to the server",
                          );
                        } else {
                          var job = snapshot.data!;
                          return VerticalTileWidget(
                            job: job,
                            onTap: () {
                              Get.to(
                                () => JobPage(id: job.id, title: job.company),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
