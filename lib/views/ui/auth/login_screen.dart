import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/controllers/login_provider.dart';
import 'package:job_finder/views/common/app_bar.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/custom_textfield.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:job_finder/views/ui/auth/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../../models/request/auth/login_request_model.dart';
import '../../common/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email =
      TextEditingController(text: "admin@gmail.com");
  final TextEditingController password = TextEditingController(text: "12345");

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        loginNotifier.getPrefs();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              title: 'Login',
              actions: const [],
              child: !loginNotifier.entrypoint
                  ? GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(CupertinoIcons.arrow_left),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: loginNotifier.loginFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const HeightSpacer(size: 50),
                  ReusableText(
                    text: "Welcome Back!",
                    style: appstyle(
                      30,
                      Color(kDark.value),
                      FontWeight.w600,
                    ),
                  ),
                  ReusableText(
                    text: "Fill the details to login your account",
                    style: appstyle(
                      16,
                      Color(kDarkGrey.value),
                      FontWeight.w600,
                    ),
                  ),
                  const HeightSpacer(size: 50),
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
                    obscureText: loginNotifier.obscureText,
                    hintText: "Password",
                    validator: (password) {
                      if (password!.isEmpty || password.length < 4) {
                        return 'please enter a valid password';
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        loginNotifier.obscureText = !loginNotifier.obscureText;
                      },
                      child: loginNotifier.obscureText
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
                        Get.to(() => const RegistrationPage());
                      },
                      child: ReusableText(
                        text: "Register",
                        style:
                            appstyle(14, Color(kDark.value), FontWeight.w500),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 50),
                  CustomButton(
                    onTap: () {
                      if (loginNotifier.validateFormAndSave()) {
                        LoginRequestModel model = LoginRequestModel(
                            email: email.text, password: password.text);
                        loginNotifier.userLogin(model);
                      } else {
                        Get.snackbar(
                          "Sign Failed",
                          "Please check your credentials and try again",
                          colorText: Color(kLight.value),
                          backgroundColor: Colors.red,
                          icon: const Icon(Icons.add_alert),
                        );
                      }
                    },
                    text: "Login",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
