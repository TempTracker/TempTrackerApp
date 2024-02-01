import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/forgetPassword_controller.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/widgets/custom_input.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController>{
  const ForgetPasswordScreen({super.key});
  @override
   @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Text("Forget your Password", style: robotoMediumWhite,),
         backgroundColor:  AppColor.primaryColor, iconTheme: const IconThemeData(
    color: Colors.white,), 
      ),
body: Padding(
  padding: const EdgeInsets.only(top: 50),
  child:   Column(
  
    children: [
  
  Text("Enter your Email to reset your password"),
  
  
  
  CustomInput(controller: controller.emailC, label: "Email", hint: ""),
  
  
  
  Padding(
    padding: const EdgeInsets.only(top: 15),
    child: SizedBox(
    
      width: double.infinity,
    
              height: size.height * 0.09,
    
    
    
      child: ElevatedButton(onPressed: (){controller.resetPassword();}, child: Text("Reset", style: robotoHugeWhite,), style: ElevatedButton.styleFrom(
    
        backgroundColor: AppColor.primaryColor
    
      ),)),
  )
  
    ],
  
  ),
),
    );
  }
}