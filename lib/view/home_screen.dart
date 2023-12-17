import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:temp_tracker/controller/home_controller.dart';

import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/view/alertsPage_screen.dart';
import 'package:temp_tracker/view/childrenList2_screen.dart';
import 'package:temp_tracker/view/settings_screen.dart';
import 'package:temp_tracker/view/tempPage_screen.dart';

class MainPageScreen extends GetView<HomeController> {
  final List<Widget> _pages = [
   SettingsScreen(),
   ChildrenList2Screen(),
   TempPageScreen(),
 AlertsPageScreen(),
  ];

  final RxInt _selectedIndex = 0.obs;

         

  @override
  Widget build(BuildContext context) {
     

    return Scaffold(
      
     appBar: AppBar(title: Padding(
      padding: EdgeInsets.all(20),
      child: Text( 'Wellcome Sara', style: robotoHugeWhite,)),
       backgroundColor: AppColor.primaryColor,   automaticallyImplyLeading: false,), 
       
      body: Obx(
        () => _pages[_selectedIndex.value],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: AppColor.primaryColor,
        backgroundColor: AppColor.whiteColor,
        index: _selectedIndex.value,
        height: 60.0,
        items: <Widget>[
         
          Icon(Icons.settings, size: 25, color: AppColor.whiteColor,),
           Icon(Icons.table_rows_rounded, size: 25, color: AppColor.whiteColor,),
          Icon(Icons.thermostat_sharp, size: 25, color: AppColor.whiteColor,),
           Icon(Icons.add_alert_rounded,size: 25, color: AppColor.whiteColor,),
        ],
        onTap: (index) {
          _selectedIndex.value = index;
        },
      ),
    );
  }
}
