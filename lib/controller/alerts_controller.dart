import 'dart:async';

import 'package:get/get.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:get/get.dart';

class AlertsController extends GetxController {
  late Timer _timer;
  RxInt _timerDurationInMinutes = 10.obs; // Initial duration in minutes

  RxInt get timerDurationInMinutes => _timerDurationInMinutes;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (_timerDurationInMinutes.value > 0) {
        _timerDurationInMinutes.value--;
      } else {
        // Timer completed, you can perform any action here
        _timer.cancel();
      }
    });
  }

 
 var isLoading = false.obs;

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
