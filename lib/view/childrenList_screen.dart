import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/controller/childrenList_controller.dart';

import 'package:temp_tracker/controller/manageChild_controller.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'package:temp_tracker/style/app_color.dart';
import 'package:temp_tracker/style/fonts.dart';
import 'package:temp_tracker/style/images.dart';

class ChildrenListScreen extends GetView<ChildrenListController> {
  const ChildrenListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Child', style: robotoHugeWhite),
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                   StreamBuilder(
              // ignore: deprecated_member_use
              stream: FirebaseDatabase.instance.reference().child("Children").orderByChild("uId")
      .equalTo(controller.uId).onValue,
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
                        var childNum = index +1;
                        
   return 
                Container(
               
                  child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.CHILDINFO, arguments: id);
                                },
                                child: Container(
                                  height: 80,
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Child $childNum : ",
                                              style: robotoMedium,
                                            ),
                                            Text(
                                              "${ data[id]["name"]}",
                                              style: robotoMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child:
                                            Icon(Icons.arrow_forward_ios_rounded),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                )
                ;
                
                                 },
                    );
                    
                  } else {
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Text("You do not have children", style: robotoMedium,),
                        Image.asset(Images.nodata),
                      ],
                    ),
                  ));
                }
                }

                return Center(child: CircularProgressIndicator()); // Show a loading indicator or error message
              },
            ),
                     
            
             
              ],
            ),
          ),
       
    
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADDCHILD);
        },
        backgroundColor: AppColor.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
