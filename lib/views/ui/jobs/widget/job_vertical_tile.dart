import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/models/response/jobs/job_response.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:job_finder/views/common/width_spacer.dart';
import 'package:job_finder/views/ui/jobs/job_page.dart';

class JobVerticalTile extends StatelessWidget {
  final JobsResponse job;
  const JobVerticalTile({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
      child: InkWell(
        onTap: () {
          Get.to(() => JobPage(id: job.id, title: job.company));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          height: height * .15,
          width: width,
          color: Color(kLightGrey.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(job.imageUrl),
                      ),
                      const WidthSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: job.company,
                            style: appstyle(
                                18, Color(kDark.value), FontWeight.w600),
                          ),
                          SizedBox(
                            width: width * .5,
                            child: ReusableText(
                              text: job.title,
                              style: appstyle(
                                  16, Color(kDarkGrey.value), FontWeight.w500),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 18.r,
                    child: Icon(
                      Ionicons.chevron_forward,
                      color: Color(kOrange.value),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 65.w),
                child: Row(
                  children: [
                    ReusableText(
                      text: job.salary,
                      style: appstyle(18, Color(kDark.value), FontWeight.w600),
                    ),
                    ReusableText(
                      text: "/monthly",
                      style:
                          appstyle(18, Color(kDarkGrey.value), FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
