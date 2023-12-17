
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/login_controller.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';

class SettingsScreen  extends  GetView<LoginController> {
   SettingsScreen ({super.key});

  @override
  Widget build(BuildContext context) {
      

          var size = MediaQuery.of(context).size;

    return  Scaffold(
     
      body: Padding(padding: EdgeInsets.only(left: 26,right: 26),
        child: Column(
          children: [
         
            SizedBox(height: 50),
            Text('Settings Page' ,style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold
            ),),                        SizedBox(height: 20),
        
           
          
        SizedBox(
              width: double.infinity,
        height: size.height * 0.09,
          child: ElevatedButton(
          onPressed: ()  async{
         Get.toNamed(Routes.USERINFO);
        
          },
           style: ElevatedButton.styleFrom(
          primary:   AppColor.primaryColor,
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
         Get.toNamed(Routes.CHILDRENLIST);
        
          },
           style: ElevatedButton.styleFrom(
          primary:   AppColor.primaryColor,
        ),
          child:
        
         Text('Manage Child'.tr ,style: robotoHugeWhite,)
          
          ),
        
        ),
        
         
        
          ],
        ),
      ),
     
    );
  }
}