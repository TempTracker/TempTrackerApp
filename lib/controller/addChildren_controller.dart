
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
void addChild() {
  isLoading = true.obs;

  if (nameC.text.isEmpty ||
      ageC.text.isEmpty ||
      emgNameC.text.isEmpty ||
      emgEmailC.text.isEmpty ||
      tempC.text.isEmpty) {
    CustomToast.errorToast('Please fill in all fields');
    return;
  }

  double temperature = double.tryParse(tempC.text) ?? 0.0;

  if (temperature > 40 || temperature < 35) {
     isLoading = false.obs;
    CustomToast.errorToast('Invalid temperature. Temperature must be between 35 and 40.');
    return;
  }

  DatabaseReference childrenRef = databaseReference.child("Children");

  // Push the data and get the key
  DatabaseReference newChildRef = childrenRef.push();
  String? childKey = newChildRef.key;

  // Set the data along with the child key
  newChildRef.set({
    'name': nameC.text,
    'age': ageC.text,
    'emergName': emgNameC.text,
    'emgEmail': emgEmailC.text,
    'temperature': tempC.text,
    'responded': 0,
    'id': childKey, // Add the child key here
    'time':"",
    'uId':uId,
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