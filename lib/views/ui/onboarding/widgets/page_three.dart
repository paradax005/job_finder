import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:job_finder/views/ui/auth/login_screen.dart';
import 'package:job_finder/views/ui/auth/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/custom_outline_button.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: kLightBlue,
        child: Column(
          children: [
            Image.asset("assets/images/page3.png"),
            const HeightSpacer(size: 20),
            ReusableText(
              text: "Welcome To JobHub",
              style: appstyle(30, kLight, FontWeight.w600),
            ),
            const HeightSpacer(size: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                "We help your find your dream job according to your skill set, location and preference to build your career",
                textAlign: TextAlign.center,
                style: appstyle(14, kLight, FontWeight.normal),
              ),
            ),
            const HeightSpacer(size: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOutlineButton(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    prefs.setBool('entrypoint', true);
                    Get.to(() => const LoginPage());
                  },
                  text: 'Login',
                  width: width * .4,
                  height: height * 0.06,
                  mainColor: Color(kLight.value),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const RegistrationPage());
                  },
                  child: Container(
                    width: width * .4,
                    height: height * 0.06,
                    color: Color(kLight.value),
                    child: Center(
                      child: ReusableText(
                        text: "Sign Up",
                        style: appstyle(
                          16,
                          kLightBlue,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const HeightSpacer(size: 25),
            ReusableText(
              text: "Continue as guest",
              style: appstyle(
                16,
                Color(kLight.value),
                FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
