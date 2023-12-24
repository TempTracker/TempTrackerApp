import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TempController extends GetxController {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    var childID = Get.arguments;


  var childrenTemps = <Map<String, dynamic>>[].obs;

     @override
  void onInit() async {
    super.onInit();
fetchChildrenTemps();
fetchChildrenData() ;
  }
  var name = ''.obs; 
  Rx<DateTime> selectedDate = DateTime.now().obs;

  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }


  void fetchChildrenData() async {
          databaseReference = FirebaseDatabase.instance.ref().child('Children');
 DataSnapshot snapshot = await databaseReference.child(childID).get();
 
    Map child = snapshot.value as Map;
 
    name.value = child['name'];
   
}



Future<void> fetchChildrenTemps() async {

  try {

    // Reference to the Firestore collection
    CollectionReference highTempsCollection =
        FirebaseFirestore.instance.collection('HighTemps');

    // Get the document with the given child ID
    DocumentSnapshot childDocument =
        await highTempsCollection.doc(childID).get();

    if (childDocument.exists) {

  
      String formattedDate =
          DateFormat('dd-MM-yyyy').format(selectedDate.value);
      CollectionReference dateCollection =
          childDocument.reference.collection(formattedDate);

      // Get all documents within the date subcollection
      QuerySnapshot dateQuery = await dateCollection.get();

      // Check if documents are found
      if (dateQuery.docs.isNotEmpty) {
        // Extract data from each document and store in the list
        List<Map<String, dynamic>> records = dateQuery.docs
            .map((doc) => {
                  'time': doc['time'],
                  'temperature': doc['temperature'],
                  'condition': doc['condition'],
                })
            .toList();

        // Set the list of records in the controller
        childrenTemps.assignAll(records);
      } else {
        print('No documents found for the specified date.');
        // Clear the list in case there are no documents
        childrenTemps.assignAll([]);
      }
    } else {

      print('Document with ID $childID does not exist in the collection.');
    }
  } catch (error) {

    print('Error fetching children: $error');
  }

}
 
}