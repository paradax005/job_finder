import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/controllers/controller.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:job_finder/views/ui/device_mgt/widgets/device_info.dart';
import 'package:job_finder/views/ui/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class DeviceManagement extends StatelessWidget {
  const DeviceManagement({super.key});

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var onBoardNotifier = Provider.of<OnBoardNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          title: "Device Management",
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpacer(size: 50),
                  Text(
                    "You are logged in into your account on these devices",
                    style: appstyle(
                      16,
                      Color(kDark.value),
                      FontWeight.normal,
                    ),
                  ),
                  const HeightSpacer(size: 50),
                  const DeviceInfo(
                    platform: "Windows",
                    date: "11-06-2023",
                    device: "MSI",
                    ipAddress: "192.111.98.11",
                    location: "Tunis",
                  ),
                  const HeightSpacer(size: 50),
                  const DeviceInfo(
                    platform: "Windows",
                    date: "11-06-2023",
                    device: "MSI",
                    ipAddress: "192.111.98.11",
                    location: "Tunis",
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Consumer<LoginNotifier>(
                builder: (context, loginNotifier, child) {
                  return GestureDetector(
                    onTap: () {
                      zoomNotifier.currentIndex = 0;
                      onBoardNotifier.isLastPage = false;
                      loginNotifier.logout();
                      Get.offAll(() => const OnBoardingScreen());
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ReusableText(
                        text: "Sign Out From All Devices",
                        style:
                            appstyle(16, Color(kOrange.value), FontWeight.w600),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
