
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
      emgEmailC.text.isEmpty
      //|| tempC.text.isEmpty
  ) {
    CustomToast.errorToast('Please fill in all fields');
    return;
  }
    double temperature = double.tryParse(tempC.text) ?? 0.0;

  int age = (double.tryParse(ageC.text) ?? 0.0).toInt();

 if (temperature > 40 || temperature < 35) {
     isLoading = false.obs;
    CustomToast.errorToast('Invalid temperature. Temperature must be between 35 and 40.');
    return;
  } else if(age > 12 ){
      isLoading = false.obs;
    CustomToast.errorToast('Invalid age. Maximum children age is 12.');
    return;
  }
  else{
  databaseReference.child(childID).update({
    'name': nameC.text,
    'age': ageC.text,
    'emergName': emgNameC.text,
    'emgEmail': emgEmailC.text,
    'alertWhen': tempC.text,
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
}







   void fetchChildren() async {
          databaseReference = FirebaseDatabase.instance.ref().child('Children');
 DataSnapshot snapshot = await databaseReference.child(childID).get();
 
    Map child = snapshot.value as Map;
 
    nameC.text = child['name'];
    ageC.text = child['age'];
    emgNameC.text = child['emergName'];
    emgEmailC.text = child['emgEmail'];
    tempC.text = child['alertWhen'];

}

}
