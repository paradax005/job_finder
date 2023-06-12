import 'package:flutter/material.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/reusable_text.dart';

class CustomOutlineButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final void Function()? onTap;
  final Color mainColor;
  final Color? outlineColor;

  const CustomOutlineButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    this.onTap,
    required this.mainColor,
    this.outlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: outlineColor,
          border: Border.all(
            color: mainColor,
            width: 1,
          ),
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(
              16,
              mainColor,
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
