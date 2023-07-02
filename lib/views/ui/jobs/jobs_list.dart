import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_finder/controllers/jobs_provider.dart';
import 'package:job_finder/models/response/jobs/job_response.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import 'widget/job_vertical_tile.dart';

class JobsList extends StatelessWidget {
  const JobsList({super.key});

  @override
  Widget build(BuildContext context) {
    var jobNotifier = Provider.of<JobsNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          title: "Jobs",
          child: InkWell(
            onTap: () => Get.back(),
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: FutureBuilder<List<JobsResponse>>(
        future: jobNotifier.jobsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text(
              "An Error occurred while connecting to the server",
            );
          } else {
            var jobs = snapshot.data;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: jobs!.length,
              itemBuilder: (context, index) {
                return JobVerticalTile(
                  job: jobs[index],
                );
              },
            );
          }
        },
      ),
    );
  }
}
