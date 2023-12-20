import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:temp_tracker/controller/login_controller.dart';
import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/style/images.dart';

class TempPageScreen extends GetView<LoginController> {
  const TempPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            StreamBuilder(
              // ignore: deprecated_member_use
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
   return     Container(
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
                              " ${ data[id]["temperature"]} °C",
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "High Temperature",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 50),
                        child: Image.asset(Images.tempgif,),
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

                return CircularProgressIndicator(); // Show a loading indicator or error message
              },
            ),
          ],
        ),
      ),
    );
  }
}
