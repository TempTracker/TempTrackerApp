

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/addChildren_controller.dart';
import 'package:temp_tracker/helper/temperatureHelper.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/widgets/custom_input.dart';

import '../../style/fonts.dart';

class AddChildScreen extends GetView<AddChildController> {

TemperatureHelper temperatureHelper = TemperatureHelper();
      String? age;
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(title: Text( 'Add Child', style: robotoHugeWhite,),
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
                  controller: controller.nameC, label:  'Child Name', hint: ''),
                  
                        
                        const SizedBox(height: 16),
                       
                             CustomInput(
                  controller: controller.ageC, label:  'Child Age', hint: '', keyboardType: TextInputType.number,  validate: (value) {
     if (value != null && double.tryParse(value) != null) { age = controller.ageC.text;}  }),
                  
                        
                        const SizedBox(height: 16),
                            CustomInput(
                  controller: controller.emgNameC, label:  'Emergency person Name', hint: ''),
                  
                                                const SizedBox(height: 16),

                             CustomInput(
                  controller: controller.emgEmailC, label:  'Emergency person Email  ', hint: '', keyboardType: TextInputType.emailAddress,),
                  
                                                const SizedBox(height: 16),
CustomInput(
  controller: controller.tempC,
  label: 'Alert when temp reaches (opt)',
  hint: '',
  keyboardType: TextInputType.number,
  validate: (value) {
     if (value != null && double.tryParse(value) != null) {
                            double temperature = double.parse(value);
                      
                             double ageDouble = double.parse(age!);

                            double upperLimit = temperatureHelper.getTemperatureLimit(ageDouble);

                            if (temperature > upperLimit) {
                              Get.snackbar(
                                'Warning',
                                'Temperature is higher than normal!',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
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
      controller.addChild();
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
