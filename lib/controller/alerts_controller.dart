import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AlertsController extends GetxController {
   late Timer _timer;
  final RxInt _timerDurationInMinutes = 10.obs; // Initial duration
 var isLoading = false.obs;
 String? childId;
 String? childIdforTimer;
  RxInt get timerDurationInMinutes => _timerDurationInMinutes;
  String? condition;
int emailsSent = 0;
DateTime lastResetDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
  startTimer();
  }




  void startTimer() async{
    _timer = Timer.periodic(const Duration(seconds: 1), (timer ) async {
      if (_timerDurationInMinutes.value > 0) {
        _timerDurationInMinutes.value--;
      } else {
        _timer.cancel();
          _timerDurationInMinutes.value = 20;
           startTimer();
 CollectionReference alertsCollection = FirebaseFirestore.instance.collection("Alerts");
    bool collectionExists = await alertsCollection.get().then((querySnapshot) => querySnapshot.docs.isNotEmpty);

      if (collectionExists) {
    FirebaseDatabase.instance
          .reference()
          .child("Children")
          .child(childId!)
          .update({"responded": 2});

          
 if (condition == 'Bracelet Removed') {
            FirebaseDatabase.instance
                .reference()
                .child("Children")
                .child(childId!)
                .update({"braceletRespond": 2});
          }
     

 deleteRecord(childIdforTimer);
      }
      else{
        print("there no Alerts");
      }
      }
    });
  }


void respond(childId) async{

  if (condition == "Bracelet Removed"){
  await FirebaseDatabase.instance
        .reference()
        .child("Children")
        .child(childId!)
        .update({"braceletRespond": 1});
  } else {
 await FirebaseDatabase.instance
        .reference()
        .child("Children")
        .child(childId!)
        .update({"responded": 1});
  }
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


Future<void> updateDataInFirestore(String? id, int? emails) async {
  CollectionReference sentByEmailCollection = FirebaseFirestore.instance.collection('SentbyEmail');

  try {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    // Reference the document with the specific id
    DocumentReference documentReference = sentByEmailCollection.doc(id);

    // Reference the subcollection for the formattedDate
    CollectionReference dateSubcollection = documentReference.collection(formattedDate);

    // Update the fields in the existing document within the subcollection
    await dateSubcollection.doc('data').set({
        'emailsNum': emails,
    }, SetOptions(merge: true));


sentByEmailCollection.doc(id).set({
      'subId': id,
    }, SetOptions(merge: true));

    print('Data updated successfully in Firestore for id: $id and date: $formattedDate');
  } catch (e) {
    print('Error updating data in Firestore: $e');
  }
}



Future<void> storeBraceletAlertsInFirestore(String? id, String name, String uId) async {
  CollectionReference alertsCollection = FirebaseFirestore.instance.collection('Alerts');

  try {
    String formattedTime = DateFormat('h:mm a').format(DateTime.now());

    await alertsCollection.add({
      'id': id, 
      'name': name,
      'condition': 'Bracelet Removed',
      'time': formattedTime,
      'uId':uId
    });

    print('Data stored successfully in Firestore');
  } catch (e) {
    print('Error storing data in Firestore: $e');
  }
}


}