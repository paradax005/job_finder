import 'package:flutter/material.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/custom_outline_button.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/reusable_text.dart';

class DeviceInfo extends StatelessWidget {
  final String location;
  final String device;
  final String platform;
  final String date;
  final String ipAddress;

  const DeviceInfo({
    super.key,
    required this.location,
    required this.device,
    required this.platform,
    required this.date,
    required this.ipAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
          text: platform,
          style: appstyle(
            22,
            Color(kDark.value),
            FontWeight.bold,
          ),
        ),
        ReusableText(
          text: device,
          style: appstyle(
            22,
            Color(kDark.value),
            FontWeight.bold,
          ),
        ),
        const HeightSpacer(size: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: date,
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w400,
                  ),
                ),
                ReusableText(
                  text: ipAddress,
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
            CustomOutlineButton(
              width: width * 0.3,
              height: height * 0.05,
              text: "Sign Out",
              mainColor: Color(kOrange.value),
            )
          ],
        )
      ],
    );
  }
}
