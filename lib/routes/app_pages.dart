
import 'package:get/get.dart';
import 'package:temp_tracker/view/addChild_screen.dart';
import 'package:temp_tracker/view/childInfo_screen.dart';
import 'package:temp_tracker/view/historicalRecord_screen.dart';
import 'package:temp_tracker/view/childrenList_screen.dart';
import 'package:temp_tracker/view/createAccount_screen.dart';
import 'package:temp_tracker/view/forgetPassword_screen.dart';
import 'package:temp_tracker/view/frontPage_screen.dart';
import 'package:temp_tracker/view/home_screen.dart';
import 'package:temp_tracker/view/login_screen.dart';
import 'package:temp_tracker/view/settings_screen.dart';
import 'package:temp_tracker/view/tempPage_screen.dart';
import 'package:temp_tracker/view/userInfo_screen.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () =>  const LoginScreen(),
    ),
    GetPage(
      name: _Paths.FRONTPAGE,
      page: () =>  const FrontPageScreen(),
    ),
     GetPage(
      name: _Paths.CREATEACCOUNT,
      page: () =>  const CreateAccountScreen(),
    ),
     GetPage(
      name: _Paths.MAINPAGE,
      page: () =>   MainPageScreen(),
    ),
      GetPage(
      name: _Paths.SETTINGS,
      page: () =>  const SettingsScreen(),
    ),
      GetPage(
      name: _Paths.USERINFO,
      page: () =>  const UserInfoScreen(),
    ),
     GetPage(
      name: _Paths.CHILDRENLIST,
      page: () =>  const ChildrenListScreen(),
    ),

     GetPage(
      name: _Paths.ADDCHILD,
      page: () =>   AddChildScreen(),
    ),
     GetPage(
      name: _Paths.CHILDINFO,
      page: () =>   ChildInfoScreen(),
    ),

     GetPage(
      name: _Paths.TEMPPAGE,
      page: () =>   TempPageScreen(),
    ),

      GetPage(
      name: _Paths.CHILDTEMPLIST,
      page: () =>   historicalRecordScreen(),
    ),


    GetPage(
      name: _Paths.FORGETPASSWORD,
      page: () =>  const ForgetPasswordScreen(),
    ),
  ];
}
