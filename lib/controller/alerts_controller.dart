import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:temp_tracker/main.dart';

class AlertsController extends GetxController {
  late Timer _timer;
  final RxInt _timerDurationInMinutes = 1.obs; // Initial duration in minutes
 var isLoading = false.obs;
 String childId = "";
  RxInt get timerDurationInMinutes => _timerDurationInMinutes;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_timerDurationInMinutes.value > 0) {
        _timerDurationInMinutes.value--;
      } else {
        // Timer completed, you can perform any action here
        _timer.cancel();
        
        // Assuming id is the unique identifier for each record
        FirebaseDatabase.instance
          .reference()
          .child("Children")
    .child(childId)
          .update({"responded": 2});

        // Set isLoading to true while updating
        isLoading.value = true;
print("going to 1 state done");
        // You can perform any additional actions or update UI as needed

        // Set isLoading back to false after the update is done
        isLoading.value = false;
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
