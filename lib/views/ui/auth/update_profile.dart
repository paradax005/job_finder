import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/controllers/controller.dart';
import 'package:job_finder/models/request/auth/update_profile_model.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/custom_button.dart';
import 'package:job_finder/views/common/custom_textfield.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
        return SafeArea(
          child: Form(
            key: loginNotifier.profileFormKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: "Personal Details",
                      style:
                          appstyle(28.sp, Color(kDark.value), FontWeight.bold),
                    ),
                    Consumer<ImageHelper>(
                      builder: (context, imageProvider, child) {
                        return GestureDetector(
                          onTap: () {
                            imageProvider.pickImage();
                          },
                          child: imageProvider.imageUrl == null
                              ? CircleAvatar(
                                  radius: 28.r,
                                  backgroundColor: Color(kLightBlue.value),
                                  child: const Center(
                                    child: Icon(Icons.photo_filter_rounded),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 28.r,
                                  backgroundImage:
                                      NetworkImage(imageProvider.imageUrl!),
                                ),
                        );
                      },
                    )
                  ],
                ),
                const HeightSpacer(size: 20),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: location,
                        hintText: "location",
                        keyboardType: TextInputType.text,
                        validator: (location) {
                          if (location!.isEmpty) {
                            return "Please enter a valid location";
                          }
                          return null;
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: phone,
                        hintText: "Phone Number",
                        keyboardType: TextInputType.text,
                        validator: (phone) {
                          if (phone!.isEmpty) {
                            return "Please enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                      const HeightSpacer(size: 10),
                      ReusableText(
                        text: "Professional Skills",
                        style: appstyle(
                            26.sp, Color(kDark.value), FontWeight.bold),
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill0,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill0) {
                          if (skill0!.isEmpty) {
                            return "Please enter a valid skill";
                          }
                          return null;
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill1,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill1) {
                          if (skill1!.isEmpty) {
                            return "Please enter a valid skill";
                          }
                          return null;
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill2,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill2) {
                          if (skill2!.isEmpty) {
                            return "Please enter a valid skill";
                          }
                          return null;
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill3,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill3) {
                          if (skill3!.isEmpty) {
                            return "Please enter a valid skill";
                          }
                          return null;
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill4,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill4) {
                          if (skill4!.isEmpty) {
                            return "Please enter a valid skill";
                          }
                          return null;
                        },
                      ),
                      const HeightSpacer(size: 20),
                      Consumer<ImageHelper>(
                          builder: (context, imageProvider, child) {
                        return CustomButton(
                          text: "Update Profile",
                          onTap: () {
                            if (imageProvider.imageF.isEmpty &&
                                imageProvider.imageUrl == null) {
                              Get.snackbar(
                                "Image Missing",
                                "Please upload an image to proceed",
                                colorText: Color(kLight.value),
                                backgroundColor: Color(kLightBlue.value),
                                icon: const Icon(Icons.add_alert),
                              );
                            } else {
                              ProfileUpdateRequest model = ProfileUpdateRequest(
                                location: location.text,
                                phone: phone.text,
                                profileImg: imageProvider.imageUrl.toString(),
                                skills: [
                                  skill0.text,
                                  skill1.text,
                                  skill2.text,
                                  skill3.text,
                                  skill4.text,
                                ],
                              );

                              loginNotifier.updateProfile(model);
                            }
                          },
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
