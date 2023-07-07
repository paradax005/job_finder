import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/app_style.dart';

class MessagingTextField extends StatelessWidget {
  const MessagingTextField({
    super.key,
    required this.messageController,
    required this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  });

  final TextEditingController messageController;
  final Widget suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Color(kDarkGrey.value),
      controller: messageController,
      keyboardType: TextInputType.multiline,
      style: appstyle(
        14,
        Color(kDark.value),
        FontWeight.normal,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(6.h),
        filled: true,
        fillColor: Color(kLight.value),
        suffixIcon: suffixIcon,
        hintText: "Type your message here",
        hintStyle: appstyle(
          14,
          Color(kDarkGrey.value),
          FontWeight.normal,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.h),
          ),
          borderSide: BorderSide(
            color: Color(kDarkGrey.value),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.h),
          ),
          borderSide: BorderSide(
            color: Color(kDarkGrey.value),
          ),
        ),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      
    );
  }
}
