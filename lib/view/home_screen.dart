import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:temp_tracker/controller/home_controller.dart';
import 'package:temp_tracker/helper/alertExitApp.dart';

import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/view/alertsPage_screen.dart';
import 'package:temp_tracker/view/childrenList2_screen.dart';
import 'package:temp_tracker/view/settings_screen.dart';
import 'package:temp_tracker/view/tempPage_screen.dart';

class MainPageScreen extends GetView<HomeController> {
  final List<Widget> _pages = [
   const SettingsScreen(),
   const ChildrenList2Screen(),
    TempPageScreen(),
  AlertsPageScreen(),
  ];

  final RxInt _selectedIndex = 0.obs;

   MainPageScreen({super.key});

     @override
Widget build(BuildContext context) {
  String? uId;
  print(uId);

  return WillPopScope(
    onWillPop: alertExitApp,
    child: Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(() {
            if (_selectedIndex.value == 1) {
              // Check if the selected index is equal to ChildrenList2Screen
              return Text('Historical Records', style: robotoHugeWhite);
            } else {
              return Text('Welcome ${controller.username}', style: robotoHugeWhite);
            }
          }),
        ),
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() => _pages[_selectedIndex.value]),
      bottomNavigationBar: CurvedNavigationBar(
        color: AppColor.primaryColor,
        backgroundColor: AppColor.whiteColor,
        index: _selectedIndex.value,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.settings, size: 25, color: AppColor.whiteColor),
          Icon(Icons.table_rows_rounded, size: 25, color: AppColor.whiteColor),
          Icon(Icons.thermostat_sharp, size: 25, color: AppColor.whiteColor),
          Icon(Icons.add_alert_rounded, size: 25, color: AppColor.whiteColor),
        ],
        onTap: (index) {
          _selectedIndex.value = index;
        },
      ),
    ),
  );
}
}