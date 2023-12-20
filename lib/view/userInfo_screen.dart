

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/userInfo_controller.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/widgets/custom_input.dart';

import '../../style/fonts.dart';

class UserInfoScreen extends GetView<UserInfoController> {
  const UserInfoScreen({super.key});
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(title: Text( 'User Information', style: robotoHugeWhite,),
       backgroundColor:  AppColor.primaryColor, iconTheme: const IconThemeData(
    color: Colors.white,), 
       ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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

                        const SizedBox(height: 16),
                       CustomInput(
                  controller: controller.emailC, label:  'Email', hint: '', disabled: true),
                  
                                                const SizedBox(height: 16),
                           CustomInput(
                  controller: controller.nameC, label:  'Name', hint: ''),
                  
                        
                        const SizedBox(height: 16),
                       
                             CustomInput(
                  controller: controller.phoneC, label:  'Phone', hint: '', keyboardType: TextInputType.number,),
                  
                        
                        const SizedBox(height: 16),
                         

                          
                        
                  //   CustomInput(
                    
                  // controller: controller.passC, label:  'Password', hint: '',obscureText: true, ),
    
                      ],
                    ),
                  ),
                ),

     
  Padding(
            padding: const EdgeInsets.all(8.0),
            child:SizedBox(
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height * 0.08,
  child: ElevatedButton(
    onPressed: () async {
      controller.updateUser() ;
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    child: Obx(
      () {
        return controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.save_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Save',
                    style: robotoMediumWhite
                  ),
                ],
              );
      },
    ),
  ),
),

          ),
             const SizedBox(height: 20),
                      
              ],
            ),
          ),
        ),
   
    );
  }
}
