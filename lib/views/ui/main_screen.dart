import 'package:flutter/material.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/views/ui/auth/profile_page.dart';
import 'package:job_finder/views/ui/bookmarks/bookmarks_page.dart';
import 'package:job_finder/views/ui/chat/chat_page.dart';
import 'package:job_finder/views/ui/device_mgt/devices_info.dart';

import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../controllers/zoom_provider.dart';
import '../common/drawer/drawer_screen.dart';

import 'home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
      return ZoomDrawer(
        menuScreen: DrawerScreen(
          indexSetter: (index) {
            zoomNotifier.currentIndex = index;
          },
        ),
        mainScreen: currentScreen(),
        angle: 0.0,
        slideWidth: 250,
        borderRadius: 30,
        showShadow: true,
        menuBackgroundColor: Color(kLightBlue.value),
      );
    });
  }

  Widget currentScreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);

    switch (zoomNotifier.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatsPage();
      case 2:
        return const BookMarkPage();
      case 3:
        return const DeviceManagement();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}
