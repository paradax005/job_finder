import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/models/response/jobs/job_response.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:job_finder/views/common/width_spacer.dart';

class VerticalTileWidget extends StatelessWidget {
  final void Function()? onTap;
  final JobsResponse job;

  const VerticalTileWidget({
    super.key,
    this.onTap,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: Color(kLightGrey.value),
          borderRadius: BorderRadius.all(
            Radius.circular(8.w),
          ),
        ),
        width: width,
        height: height * .15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(kLightGrey.value),
                      radius: 30,
                      backgroundImage: NetworkImage(job.imageUrl),
                    ),
                    const WidthSpacer(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: job.company,
                          style: appstyle(
                            18,
                            Color(kDark.value),
                            FontWeight.w600,
                          ),
                        ),
                        ReusableText(
                          text: job.title,
                          style: appstyle(
                            16,
                            Color(kDarkGrey.value),
                            FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(kLight.value),
                  child: const Icon(
                    Ionicons.chevron_forward,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Row(
                children: [
                  ReusableText(
                    text: job.salary,
                    style: appstyle(
                      16,
                      Color(kDark.value),
                      FontWeight.w600,
                    ),
                  ),
                  ReusableText(
                    text: "/${job.period}",
                    style: appstyle(
                      14,
                      Color(kDarkGrey.value),
                      FontWeight.w600,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
