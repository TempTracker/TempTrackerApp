
import 'package:get/get.dart';
import 'package:temp_tracker/view/addChild_screen.dart';
import 'package:temp_tracker/view/childInfo_screen.dart';
import 'package:temp_tracker/view/childTempList_screen.dart';
import 'package:temp_tracker/view/childrenList_screen.dart';
import 'package:temp_tracker/view/createAccount_screen.dart';
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
      page: () =>  const AddChildScreen(),
    ),
     GetPage(
      name: _Paths.CHILDINFO,
      page: () =>  const ChildInfoScreen(),
    ),

     GetPage(
      name: _Paths.TEMPPAGE,
      page: () =>  const TempPageScreen(),
    ),

      GetPage(
      name: _Paths.CHILDTEMPLIST,
      page: () =>  const ChildTempListScreen(),
    ),
  ];
}
