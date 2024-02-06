import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AlertsController extends GetxController {
   late Timer _timer;
  final RxInt highTemperatureTimer = 0.obs; // Initial duration
    final RxInt braceletRemovedTimer = 0.obs;
 var isLoading = false.obs;
 String? childId;
 String? childIdforTimer;
  RxInt get timerhighTemperatureInMinutes => highTemperatureTimer;
    RxInt get timerBraceletRemovedInMinutes => braceletRemovedTimer;

  String? condition;
int emailsSent = 0;
DateTime lastResetDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
  startTimer();
  }




//   void startTimer() async{
//     _timer = Timer.periodic(const Duration(minutes: 1), (timer ) async {
//       if (_timerDurationInMinutes.value > 0) {
//         _timerDurationInMinutes.value--;
//       } else {
//         _timer.cancel();
//           _timerDurationInMinutes.value = 20;
//            startTimer();
//  CollectionReference alertsCollection = FirebaseFirestore.instance.collection("Alerts");
//     bool collectionExists = await alertsCollection.get().then((querySnapshot) => querySnapshot.docs.isNotEmpty);

//       if (collectionExists) {
        
//          if (condition == 'Bracelet Removed') {
//             FirebaseDatabase.instance
//                 .reference()
//                 .child("Children")
//                 .child(childId!)
//                 .update({"braceletRespond": 2});

//           }
//           else if (condition == 'High Temperature')  {
//             FirebaseDatabase.instance
//           .reference()
//           .child("Children")
//           .child(childId!)
//           .update({"responded": 2});

//           }


//  deleteRecord(childIdforTimer);
//       }
//       else{
//         print("there no Alerts");
//       }
//       }
//     });
//   }



// void startTimer() async {
// CollectionReference<Map<String, dynamic>> alertsCollection =
//     FirebaseFirestore.instance.collection("Alerts");

// // Fetch documents from the "Alerts" collection
// QuerySnapshot<Map<String, dynamic>> alertsSnapshot =
//     await alertsCollection.get().then((value) => value as QuerySnapshot<Map<String, dynamic>>);



//   // Iterate through each document
//   for (QueryDocumentSnapshot<Map<String, dynamic>> alert in alertsSnapshot.docs) {
//      timerValue.value =  int.parse(alert.data()['timer']); // Assuming 'timer' is the field in your document

//     Timer.periodic(Duration(minutes:    timerValue.value ), (timer) async {
//       if (timerValue > 0) {
//         timerValue.value--;
//       } else {
//         timer.cancel();
      
//         if (condition == 'Bracelet Removed') {
//           FirebaseDatabase.instance
//               .reference()
//               .child("Children")
//               .child(childId!)
//               .update({"braceletRespond": 2});
//         } else if (condition == 'High Temperature') {
//           FirebaseDatabase.instance
//               .reference()
//               .child("Children")
//               .child(childId!)
//               .update({"responded": 2});
//         }

//         deleteRecord(childIdforTimer);
//       }
//     });
//   }
// }

void startTimer() async {
  CollectionReference<Map<String, dynamic>> alertsCollection =
      FirebaseFirestore.instance.collection("Alerts");

  // Fetch documents from the "Alerts" collection
  QuerySnapshot<Map<String, dynamic>> alertsSnapshot =
      await alertsCollection.get().then((value) => value as QuerySnapshot<Map<String, dynamic>>);


  // Iterate through each document
  for (QueryDocumentSnapshot<Map<String, dynamic>> alert in alertsSnapshot.docs) {
    String conditionValue = alert.data()['condition']; // Assuming 'condition' is the field in your document
    int timerValue = int.parse(alert.data()['timer']);

    if (conditionValue == 'Bracelet Removed') {
      braceletRemovedTimer.value = timerValue;
    } else if (conditionValue == 'High Temperature') {
      highTemperatureTimer.value = timerValue;
    }
  }

  // Set up timers based on the conditions
  if (braceletRemovedTimer != null) {
    Timer.periodic(Duration(minutes: 1), (timer) async {
  if (braceletRemovedTimer > 0) {
braceletRemovedTimer.value --;
      }

    FirebaseDatabase.instance
              .reference()
              .child("Children")
              .child(childId!)
              .update({"braceletRespond": 2});

await FirebaseFirestore.instance.collection("Alerts")
    .where('condition', isEqualTo: "Bracelet Removed")
    .get()
    .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        doc.reference.delete();
      }
    });    });
  }

  if (highTemperatureTimer != null) {
    Timer.periodic(Duration(minutes: 1), (timer) async {
        if ( highTemperatureTimer > 0) {
      highTemperatureTimer.value --;
       
    
        FirebaseDatabase.instance
              .reference()
              .child("Children")
              .child(childId!)
              .update({"responded": 2});
             
await FirebaseFirestore.instance.collection("Alerts")
    .where('condition', isEqualTo: "High Temperature")
    .get()
    .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
    
      }

        });
  }
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
      'uId':uId,
      'timer': "1"
    });

    print('Data stored successfully in Firestore');
  } catch (e) {
    print('Error storing data in Firestore: $e');
  }
}


}