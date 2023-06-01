import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_finder/views/ui/auth/login_screen.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/signup_provider.dart';

import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/custom_button.dart';
import '../../common/custom_textfield.dart';
import '../../common/height_spacer.dart';
import '../../common/reusable_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, registrationNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              title: 'Sign Up',
              actions: const [],
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const HeightSpacer(size: 50),
                ReusableText(
                  text: "Hello Welcome!",
                  style: appstyle(
                    30,
                    Color(kDark.value),
                    FontWeight.w600,
                  ),
                ),
                ReusableText(
                  text: "Fill the details to signup for an account",
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w600,
                  ),
                ),
                const HeightSpacer(size: 50),
                CustomTextField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  hintText: "Full name",
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'please enter your name';
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'please enter a valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: password,
                  keyboardType: TextInputType.text,
                  obscureText: registrationNotifier.obscureText,
                  hintText: "Password",
                  validator: (password) {
                    if (!registrationNotifier
                        .passwordValidator(password ?? "")) {
                      return " Password should contain Capital, small letter & Number & Special character";
                    }
                    return null;
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      registrationNotifier.obscureText =
                          !registrationNotifier.obscureText;
                    },
                    child: registrationNotifier.obscureText
                        ? Icon(
                            Icons.visibility_off,
                            color: Color(kDark.value),
                          )
                        : Icon(
                            Icons.visibility,
                            color: Color(kDark.value),
                          ),
                  ),
                ),
                const HeightSpacer(size: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const LoginPage());
                    },
                    child: ReusableText(
                      text: "Login",
                      style: appstyle(14, Color(kDark.value), FontWeight.w500),
                    ),
                  ),
                ),
                const HeightSpacer(size: 50),
                CustomButton(
                  onTap: () {},
                  text: "Sign Up",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}