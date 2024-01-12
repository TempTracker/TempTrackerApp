
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/widgets/custom_toast.dart';

class ManageChildController extends GetxController {



     @override
  void onInit() async {
    super.onInit();

fetchChildren() ;
  }

    var childID = Get.arguments;

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  TextEditingController nameC = TextEditingController();
  TextEditingController ageC = TextEditingController();
  TextEditingController emgNameC = TextEditingController();
  TextEditingController emgEmailC = TextEditingController();
  TextEditingController tempC = TextEditingController();
  var isLoading = false.obs;


 void Clear(){
      nameC.clear();
      ageC.clear();
      emgNameC.clear();
      emgEmailC.clear();
      tempC.clear();
 }

void updateChild() {
 
  isLoading = true.obs;

  if (nameC.text.isEmpty ||
      ageC.text.isEmpty ||
      emgNameC.text.isEmpty ||
      emgEmailC.text.isEmpty ||
      tempC.text.isEmpty) {
    CustomToast.errorToast('Please fill in all fields');
    return;
  }

  databaseReference.child(childID).update({
    'name': nameC.text,
    'age': ageC.text,
    'emergName': emgNameC.text,
    'emgEmail': emgEmailC.text,
    'temperature': tempC.text,
  }).then((value) {
    isLoading = false.obs;
    CustomToast.successToast('Updated Child successfully');
    Clear();
  }).catchError((error) {
    isLoading = false.obs;
    // Handle error
    CustomToast.errorToast('Error updating child: $error');
  });
  
}







   void fetchChildren() async {
          databaseReference = FirebaseDatabase.instance.ref().child('Children');
 DataSnapshot snapshot = await databaseReference.child(childID).get();
 
    Map child = snapshot.value as Map;
 
    nameC.text = child['name'];
    ageC.text = child['age'];
    emgNameC.text = child['emergName'];
    emgEmailC.text = child['emgEmail'];
    tempC.text = child['temperature'];

}

}
