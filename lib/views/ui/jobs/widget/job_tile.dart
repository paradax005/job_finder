import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:job_finder/views/common/width_spacer.dart';

class VerticalTileWidget extends StatelessWidget {
  final void Function()? onTap;

  const VerticalTileWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        color: Color(kLightGrey.value),
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
                      backgroundImage:
                          const AssetImage("assets/images/slack.png"),
                    ),
                    const WidthSpacer(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "Slack",
                          style: appstyle(
                            20,
                            Color(kDark.value),
                            FontWeight.w600,
                          ),
                        ),
                        ReusableText(
                          text: "Django Developer",
                          style: appstyle(
                            20,
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
                    text: "20K",
                    style: appstyle(
                      23,
                      Color(kDark.value),
                      FontWeight.w600,
                    ),
                  ),
                  ReusableText(
                    text: "/monthly",
                    style: appstyle(
                      23,
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
