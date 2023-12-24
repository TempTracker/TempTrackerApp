import 'package:firebase_database/firebase_database.dart';
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
    return Stack(

      children:[ 
        Scaffold(
        body:  SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              children: [
                    StreamBuilder(
 stream: FirebaseDatabase.instance
      .reference()
      .child("Children")
      .orderByChild("responded")
      .equalTo(0)
      .onValue,
        builder: (context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      var data = snapshot.data!.snapshot.value;
      if (data != null) {
        List<String> ids = List<String>.from(data.keys);
 
        return ListView.builder(
          shrinkWrap: true,
          itemCount: ids.length,
          itemBuilder: (context, index) {
            var id = ids[index];
        controller.childId= id ;
            return  Container(
                  padding: const EdgeInsets.all(15),
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
                          offset: const Offset(0, 3),
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
                                      const Text(
                                        "High Temperature",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                       const SizedBox(width: 60),
                                      Text(
                                        "${data[id]["time"]}",
                                        style: robotoBlack,
                                      ),
                                    ],
                                  ),
                              
                                       Obx(() {
              return Text(
                "${data[id]["name"]}'s body temperature is now abnormal \n response within ${controller.timerDurationInMinutes.value} minutes.",
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
                            onPressed: () async {
  await FirebaseDatabase.instance
        .reference()
        .child("Children")
        .child(id)
        .update({"responded": 1});

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                            ),
                            child: Obx(
                              () {
                                return controller.isLoading.value
                                    ? const CircularProgressIndicator(
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
                );
             },
        );
  
      }
      else {
          return Center(child: Text("No data available."));
        }
    }

    return Center(child: CircularProgressIndicator()); // Show a loading indicator or error message
  },
),

              
              ],
            ),
        
            ),
    
         
      ),
                        const Positioned(bottom: 30,left:15, child:  Row(
                          children: [
                            Icon(Icons.crisis_alert_rounded),
                                                        Text("If there is no response in the specified time,\n an alert will be sent to emergency person."),

                          ],
                        ))

   ] );
  }
}
