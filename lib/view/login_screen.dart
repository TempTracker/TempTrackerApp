
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/login_controller.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/widgets/custom_input.dart';

class LoginScreen  extends  GetView<LoginController> {
   LoginScreen ({super.key});

  @override
  Widget build(BuildContext context) {
      

          var size = MediaQuery.of(context).size;

    return  Scaffold(
      appBar: AppBar(title: Text( 'Login', style: robotoHugeWhite,),
       backgroundColor:  AppColor.primaryColor, iconTheme: IconThemeData(
    color: Colors.white,), 
       ),
      body: Padding(padding: EdgeInsets.only(left: 26,right: 26),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1,),
      //          Container(
      //   width: size.width * 1 , 
      //   height: size.height * 0.2,
      //   child: Image.asset(Images.Logo),
      // ),
              SizedBox(height: 50),
              Text('LOGIN' ,style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold
              ),),                        SizedBox(height: 20),
    
                CustomInput(
                  controller: controller.emailC, label:  'Email', hint: ''),
                  
                                                SizedBox(height: 16),

                          
                        
                    CustomInput(
                    
                  controller: controller.passC, label:  'Password', hint: '',obscureText: true),
    
                                    SizedBox(height:30),
      
          SizedBox(
                width: double.infinity,
        height: size.height * 0.09,
            child: ElevatedButton(
            onPressed: ()  async{
 Get.toNamed(Routes.MAINPAGE);

            },
             style: ElevatedButton.styleFrom(
            primary:   AppColor.primaryColor,
          ),
            child:Obx(
        () {
      return controller.isLoading.value
          ? CircularProgressIndicator(color: Colors.white,)
          :  Text('login'.tr ,style: robotoHugeWhite,);
        },
      ),
    
          ),
          ),
    
           
    
            ],
          ),
        ),
      ),
   
    );
  }
}