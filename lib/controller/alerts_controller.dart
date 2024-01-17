import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/main.dart';

class AlertsController extends GetxController {
  late Timer _timer;
  final RxInt _timerDurationInMinutes = 20.obs; // Initial duration
 var isLoading = false.obs;
 String? childId;
 String? childIdforTimer;
  RxInt get timerDurationInMinutes => _timerDurationInMinutes;
  

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() async{
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerDurationInMinutes.value > 0) {
        _timerDurationInMinutes.value--;
      } else {
        _timer.cancel();
          _timerDurationInMinutes.value = 40;
           startTimer();
      
        FirebaseDatabase.instance
          .reference()
          .child("Children")
    .child(childId!)
          .update({"responded": 2});

 deleteRecord(childIdforTimer);
        isLoading.value = true;
print("going to 1 state done");
     
        isLoading.value = false;
      }
    });
  }


void respond(childId) async{
  await FirebaseDatabase.instance
        .reference()
        .child("Children")
        .child(childId!)
        .update({"responded": 1});
}


void deleteRecord(childId) async {
  try {
       await FirebaseFirestore.instance.collection("Alerts").doc(childId).delete();

    print('Successfully deleted record with childId: $childId');
  } catch (e) {
    print('Error deleting record: $e');
  }
}
  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
