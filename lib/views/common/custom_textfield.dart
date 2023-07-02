import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/views/common/app_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String hintText;
  final Widget? suffixIcon;
  final void Function()? onEditingComplete;

  final Color? hintColor;
  final Color? containerColor;

  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText,
    required this.hintText,
    this.suffixIcon,
    this.onEditingComplete,
    this.hintColor,
    this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      color: containerColor ?? Color(kLightGrey.value),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        validator: validator,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          hintText: hintText.toUpperCase(),
          suffixIcon: suffixIcon,
          hintStyle: appstyle(
            12.sp,
            hintColor ?? Color(kDarkGrey.value),
            FontWeight.w400,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: Colors.red,
              width: .5,
            ),
          ),
        ),
      ),
    );
  }
}
