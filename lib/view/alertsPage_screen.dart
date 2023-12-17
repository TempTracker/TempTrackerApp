import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/alerts_controller.dart';


import 'package:temp_tracker/style/app_color.dart';

import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/style/images.dart';
class AlertsPageScreen extends GetView<AlertsController> {
  const AlertsPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(

      children:[ 
        Scaffold(
        body:  SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 10),
                              child: Image.asset(Images.tempgif),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "High Temperature",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                       SizedBox(width: 60),
                                      Text(
                                        "9:20 PM",
                                        style: robotoBlack,
                                      ),
                                    ],
                                  ),
                              
                                       Obx(() {
              return Text(
                "Deema body temperature is now abnormal \n response within ${controller.timerDurationInMinutes.value} minutes.",
                style: robotoMedium,
              );
            }),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 15,
                          child: ElevatedButton(
                            onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.primaryColor,
                            ),
                            child: Obx(
                              () {
                                return controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Respond',
                                        style: robotoMediumWhite,
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 10),
                              child: Image.asset(Images.tempgif),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "High Temperature",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                       SizedBox(width: 60),
                                      Text(
                                        "9:25 PM",
                                        style: robotoBlack,
                                      ),
                                    ],
                                  ),
                              
                                       Obx(() {
              return Text(
                "Mohammed body temperature is now abnormal \n response within ${controller.timerDurationInMinutes.value} minutes.",
                style: robotoMedium,
              );
            }),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 15,
                          child: ElevatedButton(
                            onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.primaryColor,
                            ),
                            child: Obx(
                              () {
                                return controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Respond',
                                        style: robotoMediumWhite,
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               

                 Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 10),
                              child: Image.asset(Images.tempgif),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "High Temperature",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                       SizedBox(width: 60),
                                      Text(
                                        "9:25 PM",
                                        style: robotoBlack,
                                      ),
                                    ],
                                  ),
                              
                                       Obx(() {
              return Text(
                "Ali body temperature is now abnormal \n response within ${controller.timerDurationInMinutes.value} minutes.",
                style: robotoMedium,
              );
            }),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 15,
                          child: ElevatedButton(
                            onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.primaryColor,
                            ),
                            child: Obx(
                              () {
                                return controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Respond',
                                        style: robotoMediumWhite,
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               

              
              ],
            ),
        
            ),
    
         
      ),
                        Positioned(bottom: 30,left:15, child:  Row(
                          children: [
                            Icon(Icons.crisis_alert_rounded),
                                                        Text("If there is no response in the specified time,\n an alert will be sent to emergency person."),

                          ],
                        ))

   ] );
  }
}
