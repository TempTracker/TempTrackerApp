
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/login_controller.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/style/images.dart';

class FrontPageScreen  extends  GetView<LoginController> {
   FrontPageScreen ({super.key});

  @override
  Widget build(BuildContext context) {
      

          var size = MediaQuery.of(context).size;

    return  Scaffold(
    
        body: Stack(
          children: [
            Padding(padding: EdgeInsets.only(left: 26,right: 26),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.1,),
                     Container(
              width: size.width * 1 , 
              height: size.height * 0.2,
              child: Image.asset(Images.logo),
            ),
                    SizedBox(height: 50),
                    Text('Temp Tracker'.tr ,style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold
                    ),),                      
    
                  
                                          SizedBox(height:80),
        
                SizedBox(
                      width: double.infinity,
              height: size.height * 0.09,
                  child: ElevatedButton(
                  onPressed: ()  async{
        Get.toNamed(Routes.LOGIN);
                  },
                   style: ElevatedButton.styleFrom(
                  primary:   AppColor.primaryColor,
                ),
                  child:
        Text('login'.tr ,style: robotoHugeWhite,)
          
        
    
                ),
                ),
      SizedBox(height: 20),
                 SizedBox(
                      width: double.infinity,
              height: size.height * 0.09,
                  child: ElevatedButton(
                  onPressed: ()  async{
       Get.toNamed(Routes.CREATEACCOUNT);
                  },
                   style: ElevatedButton.styleFrom(
                  primary:  AppColor.primaryColor,
                ),
                  child:
        Text('Create Account'.tr ,style: robotoHugeWhite,)
          
        
    
                ),
                ),
    
    
                  ],
                ),
              ),
            )
          ],
        ),
     
    );
  }
}