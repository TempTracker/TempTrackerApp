import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: "Warning",
      titleStyle:const  TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold),
      middleText: "Do you want to logout?",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.redColor)),
            onPressed: () {
            //  exit(0);
            Get.offAllNamed(Routes.FRONTPAGE);
            },
            child: Text("Yes", style: robotoMediumWhite,)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.primaryColor)),
            onPressed: () {
              Get.back();
            },
            child: Text("No", style: robotoMediumWhite,))
      ]);
  return Future.value(true);
}