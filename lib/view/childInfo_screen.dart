

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/manageChild_controller.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/widgets/custom_input.dart';

import '../../style/fonts.dart';


class ChildInfoScreen extends GetView<ManageChildController> {
  ChildInfoScreen({Key? key});
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(title: Text( 'Deema Information', style: robotoHugeWhite,),
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

                        SizedBox(height: 16),
                    
                           CustomInput(
                  controller: controller.nameC, label:  'Child Name', hint: ''),
                  
                        
                        SizedBox(height: 16),
                       
                             CustomInput(
                  controller: controller.AgeC, label:  'Child Age', hint: ''),
                  
                        
                        SizedBox(height: 16),
                            CustomInput(
                  controller: controller.EmgNameC, label:  'Emergency person Name', hint: ''),
                  
                                                SizedBox(height: 16),

                             CustomInput(
                  controller: controller.EmgPhoneC, label:  'Emergency person Phone  ', hint: '', keyboardType: TextInputType.number,),
                  
                                                SizedBox(height: 16),
CustomInput(
  controller: controller.tempC,
  label: 'Alert when temp reaches (opt)',
  hint: '',
  keyboardType: TextInputType.number,
  validate: (value) {
    if (value != null && double.tryParse(value) != null) {
      double temperature = double.parse(value);
      if (temperature > 37) {
        Get.snackbar(
          'Warning',
          'Temperature is higher than normal!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    }
    return null;
  },
),

                   
    
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
            ? CircularProgressIndicator(color: Colors.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Save Changes',
                    style: robotoMediumWhite
                  ),
                ],
              );
      },
    ),
  ),
),

          ),
             SizedBox(height: 20),
                      
              ],
            ),
          ),
        ),
   
    );
  }
}
