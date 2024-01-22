
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_tracker/widgets/custom_toast.dart';

class AddChildController extends GetxController {
    TextEditingController ageC = TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  TextEditingController emgNameC = TextEditingController();
  TextEditingController emgEmailC = TextEditingController();
 var isLoading = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController tempC = TextEditingController();

  late SharedPreferences _prefs;
String? uId ;
 @override
  void onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    uId = _prefs.getString('userId') ?? '';
  }


 void Clear(){
   nameC.clear();
      ageC.clear();
      emgNameC.clear();
      emgEmailC.clear();
      tempC.clear();
 }



void addChild() async {
  isLoading = true.obs;

  if (nameC.text.isEmpty ||
      ageC.text.isEmpty ||
      emgNameC.text.isEmpty ||
      emgEmailC.text.isEmpty 
   ) {
    CustomToast.errorToast('Please fill in all fields');
    return;
  }

  double temperature = double.tryParse(tempC.text) ?? 0.0;
  int age = (double.tryParse(ageC.text) ?? 0.0).toInt();

  if ((temperature < 35 || temperature > 40) && temperature != 0.0)  {
    isLoading = false.obs;
    CustomToast.errorToast('Invalid temperature. Temperature must be between 35 and 40.');
    return;
  } else if (age > 12) {
    isLoading = false.obs;
    CustomToast.errorToast('Invalid age. Maximum children age is 12.');
    return;
  } else {
    DatabaseReference childrenRef = databaseReference.child("Children");

    // Retrieve the current count of children
    DatabaseEvent event = await childrenRef.once();

    DataSnapshot snapshot = event.snapshot;

    int childCount = snapshot.value == null ? 0 : (snapshot.value as Map).length;

    // Generate the next child key
    String childKey = "child ${childCount + 1}";

    // Set the data along with the child key
    DatabaseReference newChildRef = childrenRef.child(childKey);

    newChildRef.set({
      'name': nameC.text,
      'age': ageC.text,
      'emergName': emgNameC.text,
      'emgEmail': emgEmailC.text,
      'alertWhen': tempC.text,
      'responded': 0,
      'braceletRespond': 0,
      'id': childKey, 
      'time': "",
      'uId': uId,
      'emailsNum': 0,
      'temperature': "0"

    }).then((value) {
      isLoading = false.obs;
      CustomToast.successToast('Added Child successfully');
      Clear();
    }).catchError((error) {
      isLoading = false.obs;

      // Handle error
      CustomToast.errorToast('Error adding child: $error');
    });
  }
}

}