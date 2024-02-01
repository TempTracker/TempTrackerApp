import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/alerts_controller.dart';
import 'package:temp_tracker/controller/home_controller.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/style/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlertsPageScreen extends GetView<AlertsController> {
  HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('Alerts')
                      .where('uId', isEqualTo: homeController.uId)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data?.docs;
                      
                      if (data != null && data.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var document = data[index];
                            controller.childId =document["id"];
                            var id = document.id;
                            var childId = document["id"];
                            controller.childIdforTimer =  document.id;
String? condition ;
controller.condition =  document["condition"];

String? imageUrl;
     if ( document["condition"] == 'High Temperature') {
      condition = 'High Temperature';
      imageUrl = Images.tempgif; 
    } else if ( document["condition"] == 'Bracelet Removed') {
       condition = 'Bracelet Not Found';
      print('Condition: $condition');
      imageUrl = Images.notFound; 
    }

                            return Container(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.18,
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
                                          child: Image.asset(imageUrl!),
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
                                                  condition!,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                        color:  document["condition"] == 'High Temperature' ? Colors.red : Colors.blue,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 30),
                                                  Text(
                                                    "${document["time"]}",
                                                    style: robotoBlack,
                                                  ),
                                                ],
                                              ),
                                              Obx(() {
                                                return Text(
                                                 document["condition"] ==  'High Temperature' ? "${document["name"]}'s body temperature is now abnormal \n response within ${controller.timerDurationInMinutes.value} minutes." : "${document["name"]} is NOT wearing the bracelet \n response within ${controller.timerDurationInMinutes.value} minutes.",
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
                                          controller.respond(childId);
                                          controller.deleteRecord(id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.primaryColor,
                                        ),
                                        child:Text(
                                              'Respond',
                                              style: robotoMediumWhite,
                                        ),
                                          
                                        
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
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
        const Positioned(
          bottom: 30,
          left: 15,
          child: Row(
            children: [
              Icon(Icons.crisis_alert_rounded),
              Text(
                "If there is no response in the specified time,\n an alert will be sent to emergency person.",
              ),
            ],
          ),
        )
      ],
    );
  }
}
