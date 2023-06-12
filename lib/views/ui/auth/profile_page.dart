import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:job_finder/views/common/width_spacer.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          title: "Profile",
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: width,
              height: height * 0.12,
              color: Color(kLight.value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        child: CachedNetworkImage(
                          width: 80.w,
                          height: 100.h,
                          imageUrl:
                              "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                        ),
                      ),
                      const WidthSpacer(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: "John Doe",
                            style: appstyle(
                                20, Color(kDark.value), FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Icon(
                                MaterialIcons.location_pin,
                                color: Color(kDarkGrey.value),
                              ),
                              const WidthSpacer(width: 5),
                              ReusableText(
                                text: "Washignton DC",
                                style: appstyle(16, Color(kDarkGrey.value),
                                    FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Feather.edit,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
            const HeightSpacer(size: 20),
            Stack(
              children: [
                Container(
                  width: width,
                  height: height * 0.12,
                  color: Color(kLightGrey.value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 12.w),
                        width: 60.w,
                        height: 70.h,
                        color: Color(kLight.value),
                        child: const Icon(
                          FontAwesome5Regular.file_pdf,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: "Resume from JobHub",
                            style: appstyle(
                                18, Color(kDark.value), FontWeight.w500),
                          ),
                          ReusableText(
                            text: "JobHub Resume",
                            style: appstyle(
                                16, Color(kDarkGrey.value), FontWeight.w500),
                          )
                        ],
                      ),
                      const WidthSpacer(width: 1),
                    ],
                  ),
                ),
                Positioned(
                  top: 2.h,
                  right: 5.w,
                  child: GestureDetector(
                    onTap: () {},
                    child: ReusableText(
                      text: "Edit",
                      style:
                          appstyle(16, Color(kOrange.value), FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            const HeightSpacer(size: 20),
            Container(
              padding: EdgeInsets.only(left: 8.w),
              width: width,
              height: height * 0.06,
              color: Color(kLightGrey.value),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ReusableText(
                  text: "paradax005@gmail.com",
                  style: appstyle(16, Color(kDark.value), FontWeight.w600),
                ),
              ),
            ),
            const HeightSpacer(size: 20),
            Container(
              padding: EdgeInsets.only(left: 8.w),
              width: width,
              height: height * 0.06,
              color: Color(kLightGrey.value),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ReusableText(
                  text: "+216 29 852 228",
                  style: appstyle(16, Color(kDark.value), FontWeight.w600),
                ),
              ),
            ),
            const HeightSpacer(size: 20),
            Container(
              color: Color(kLightGrey.value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: ReusableText(
                      text: "Skills",
                      style: appstyle(16, Color(kDark.value), FontWeight.w600),
                    ),
                  ),
                  const HeightSpacer(size: 3),
                  SizedBox(
                    height: height * 0.5,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: skills.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                width: width,
                                height: height * 0.06,
                                color: Color(kLight.value),
                                child: ReusableText(
                                  text: skills[index],
                                  style: appstyle(
                                    16,
                                    Color(kDark.value),
                                    FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
