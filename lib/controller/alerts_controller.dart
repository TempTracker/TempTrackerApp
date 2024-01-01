import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/main.dart';

class AlertsController extends GetxController {
  late Timer _timer;
  final RxInt _timerDurationInMinutes = 20.obs; // Initial duration in minutes
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
        // Timer completed, you can perform any action here
        _timer.cancel();
          _timerDurationInMinutes.value = 40;
           startTimer();
        // Assuming id is the unique identifier for each record
        FirebaseDatabase.instance
          .reference()
          .child("Children")
    .child(childId!)
          .update({"responded": 2});

 deleteRecord(childIdforTimer);
        // Set isLoading to true while updating
        isLoading.value = true;
print("going to 1 state done");
        // You can perform any additional actions or update UI as needed

        // Set isLoading back to false after the update is done
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
