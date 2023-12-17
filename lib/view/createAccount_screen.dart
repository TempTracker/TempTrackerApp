

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/createAccount_controller.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/widgets/custom_input.dart';

import '../../style/fonts.dart';

class CreateAccountScreen extends GetView<CreateAccountController> {
  CreateAccountScreen({Key? key});
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(title: Text( 'Create Account', style: robotoHugeWhite,),
       backgroundColor:  AppColor.primaryColor, iconTheme: IconThemeData(
    color: Colors.white,), 
       ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                   decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), 
                          borderRadius: BorderRadius.circular(6.0), 
                        ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text('Please complete all the information to create an account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),

                        SizedBox(height: 16),
                    
                           CustomInput(
                  controller: controller.nameC, label:  'Name', hint: ''),
                  
                        
                        SizedBox(height: 16),
                       
                             CustomInput(
                  controller: controller.nameC, label:  'Phone', hint: ''),
                  
                        
                        SizedBox(height: 16),
                            CustomInput(
                  controller: controller.emailC, label:  'Email', hint: ''),
                  
                                                SizedBox(height: 16),

                          
                        
                    CustomInput(
                    
                  controller: controller.passC, label:  'Password', hint: '',obscureText: true,),
    
                      ],
                    ),
                  ),
                ),

     
  Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height * 0.08 ,
              child: ElevatedButton(
                onPressed: () async{
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), 
                  ),
                ),
                child: Obx(
              () {
                return controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white,)
                    :   Text(
                'Create Account',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                );
              },
            ),
              ),
            ),
          ),
             SizedBox(height: 20),
                          GestureDetector(child: Text('Do you already have an account?' ,style:robotoBold ,) ,onTap: () {
                         Get.toNamed( Routes.LOGIN);
                          },),
              ],
            ),
          ),
        ),
   
    );
  }
}
