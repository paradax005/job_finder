import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';
import 'app_style.dart';
import 'height_spacer.dart';
import 'reusable_text.dart';

class Loader extends StatelessWidget {
  final String message;
  const Loader({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/optimized_search.png"),
          const HeightSpacer(size: 20),
          ReusableText(
            text: message,
            style: appstyle(22, Color(kDark.value), FontWeight.bold),
          )
        ],
      ),
    );
  }
}