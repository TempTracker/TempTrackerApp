
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
 
 var completedTasksCount = 0.obs;
 

// //   // Function to store data in Firestore
// Future<void> storeDataInFirestore(String? id, String name, double temperature) async {
//   CollectionReference highTempsCollection = FirebaseFirestore.instance.collection('HighTemps').doc(id);

//   try {
//     String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//      String formattedTime = DateFormat('h:mm a').format(DateTime.now());
//     CollectionReference todayCollection = highTempsCollection.doc(id).collection(formattedDate);

//     await todayCollection.add({
//       'id': id,
//       'name': name,
//       'temperature': temperature,
//       'condition': 'High Temperature',
//       'time': formattedTime,
//     });

//     print('Data stored successfully in Firestore');
//   } catch (e) {
//     print('Error storing data in Firestore: $e');
//   }
// }

// Function to store data in Firestore
Future<void> storeDataInFirestore(String? id, String name, double temperature) async {
  CollectionReference highTempsCollection = FirebaseFirestore.instance.collection('HighTemps');

  try {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String formattedTime = DateFormat('h:mm a').format(DateTime.now());
    CollectionReference todayCollection = highTempsCollection.doc(id).collection(formattedDate);

    await todayCollection.add({
      'name': name,
      'temperature': temperature,
      'condition': 'High Temperature',
      'time': formattedTime,
    });

    // Add 'subId' field outside the 'todayCollection'
    highTempsCollection.doc(id).set({
      'subId': id,
    });

    print('Data stored successfully in Firestore');
  } catch (e) {
    print('Error storing data in Firestore: $e');
  }
}



Future<void> changeTime(String id ) async {
     String formattedTime = DateFormat('h:mm a').format(DateTime.now());
   FirebaseDatabase.instance
          .reference()
          .child("Children")
    .child(id)
          .update({"time": formattedTime});

 
}



}