import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_tracker/controller/alerts_controller.dart';
import 'package:temp_tracker/controller/createAccount_controller.dart';
import 'package:temp_tracker/controller/home_controller.dart';
import 'package:temp_tracker/controller/manageChild_controller.dart';
import 'package:temp_tracker/controller/temp_controller.dart';



import '../controller/login_controller.dart';

Future init() async {



  Get.lazyPut(() => LoginController(), fenix: true);
Get.lazyPut(() => CreateAccountController(), fenix: true);
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => ManageChildController(), fenix: true);
  Get.lazyPut(() => AlertsController(), fenix: true);
  Get.lazyPut(() => TempController(), fenix: true);


}
