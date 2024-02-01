import 'package:flutter/material.dart';
import 'package:temp_tracker/style/images.dart';

class TemperatureHelper {
  double getTemperatureLimit(double age) {
    if (age >= 0 && age <= 2) {
      return 38.0;
    } else if (age >= 3 && age <= 10) {
      return 37.8;
    } else {
      return 37.6;
    }
  }

  String getTemperatureStatus(double temperature, double upperLimit) {
    return (temperature > upperLimit) ? "High Temperature" : "Normal";
  }

  String getTemperatureImagePath(double temperature, double upperLimit) {
    return (temperature > upperLimit) ? Images.tempgif : Images.normalTemp;
  }
}
