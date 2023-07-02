import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/views/common/width_spacer.dart';

import '../../constants/app_constants.dart';

class HorizontalShimmer extends StatelessWidget {
  const HorizontalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        ShimmerEffect(
          curve: Curves.easeInBack,
          duration: const Duration(seconds: 7),
          colors: [
            Color(kLightGrey.value),
            Color(kLightBlue.value),
            Color(kLightGrey.value),
          ],
        ),
      ],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                width: width * .7,
                height: height * .27,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                color: Color(kLightGrey.value),
              ),
              const WidthSpacer(width: 10),
            ],
          );
        },
      ),
    );
  }
}
