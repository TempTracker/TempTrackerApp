
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/login_controller.dart';
import 'package:temp_tracker/helper/alertExitApp.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';

class SettingsScreen  extends  GetView<LoginController> {
   const SettingsScreen ({super.key});

  @override
  Widget build(BuildContext context) {
      

          var size = MediaQuery.of(context).size;

    return  Scaffold(
     
      body: Padding(padding: const EdgeInsets.only(left: 26,right: 26),
        child: Column(
          children: [
         
            const SizedBox(height: 50),
            const Text('Settings Page' ,style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold
            ),),                        const SizedBox(height: 20),
        
           
          
        SizedBox(
              width: double.infinity,
        height: size.height * 0.09,
          child: ElevatedButton(
          onPressed: ()  async{
         Get.toNamed(Routes.USERINFO);
        
          },
           style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
        ),
          child:
        
         Text('User Information'.tr ,style: robotoHugeWhite,)
          
          ),
        
        ),
        SizedBox(height: MediaQuery.of(context).size.height *0.05,),
        
          SizedBox(
              width: double.infinity,
        height: size.height * 0.09,
          child: ElevatedButton(
          onPressed: ()  async{
         Get.toNamed(Routes.CHILDRENLIST,  arguments: controller.auth.currentUser!.uid);
        
          },
           style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
        ),
          child:
        
         Text('Manage Child'.tr ,style: robotoHugeWhite,)
          
          ),
        
        ),
        
            SizedBox(height: MediaQuery.of(context).size.height *0.05,),
        
          SizedBox(
              width: double.infinity,
        height: size.height * 0.09,
          child: ElevatedButton.icon(
            icon: Icon(Icons.logout_outlined, color: Colors.white,),
          
          onPressed: ()  async{
    alertExitApp();
        
          },
           style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
        ),
        label:
        
         Text('Logout'.tr ,style: robotoHugeWhite,)
          
          ),
        
        ),
        
        
          ],
        ),
      ),
     
    );
  }
}