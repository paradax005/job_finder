import 'package:flutter/material.dart';
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

  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText,
    required this.hintText,
    this.suffixIcon,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(kOrange.value),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        validator: validator,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          hintText: hintText.toUpperCase(),
          suffixIcon: suffixIcon,
          hintStyle: appstyle(16, Color(kLight.value), FontWeight.w500),
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
