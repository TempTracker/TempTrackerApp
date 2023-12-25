import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/home_controller.dart';
import 'package:temp_tracker/helper/temperatureHelper.dart';

import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/style/images.dart';

class TempPageScreen extends GetView<HomeController> {
  bool isStoringData = false;
  
  TemperatureHelper temperatureHelper = TemperatureHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
         StreamBuilder(
  stream: FirebaseDatabase.instance.reference().child("Children").onValue,
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

  //           // Extract temperature value and convert it to a double
            double temperature = double.tryParse(data[id]["temperature"] ?? "0.0") ?? 0.0;
            double age  = double.tryParse(data[id]["age"] ?? "0.0") ?? 0.0;

  double upperLimit = temperatureHelper.getTemperatureLimit(age);
                  String temperatureStatus = temperatureHelper.getTemperatureStatus(temperature, upperLimit);
                  String imagePath = temperatureHelper.getTemperatureImagePath(temperature, upperLimit);
            return Container(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data[id]["name"]} current temperature:",
                              style: robotoHuge,
                            ),
                            Text(
                              " ${temperature} °C",
                              style: TextStyle(
                                fontSize: 40,
                                color: (temperature > upperLimit)
                                    ? Colors.red
                                    : Colors.black, // Adjust color based on condition
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              temperatureStatus,
                              style: TextStyle(
                                fontSize: 25,
                                color: (temperature > upperLimit)
                                    ? Colors.red
                                    : Colors.black, // Adjust color based on condition
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 50),
                        child: Image.asset(imagePath),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
        }
      else {
          return Center(child: Text("No data available."));
        
      
    }

    return Center(child: CircularProgressIndicator()); // Show a loading indicator or error message
  },
),

          ],
        ),
      ),
    );
  }

}
