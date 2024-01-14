import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_tracker/controller/alerts_controller.dart';
import 'package:temp_tracker/controller/home_controller.dart';
import 'package:temp_tracker/firebase_options.dart';
import 'package:temp_tracker/helper/temperatureHelper.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'helper/git_di.dart' as di;



final FlutterLocalNotificationsPlugin flutterLocalPlugin =FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel notificationChannel=AndroidNotificationChannel(
  'temperature_alerts',
    "Warning",
    
  importance: Importance.max,
  showBadge: true

);

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
 //await initializeFirebase();
   //  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

 Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 await initservice();
  await di.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());


}
AlertsController alertsController = AlertsController();
HomeController homeController =  HomeController();
TemperatureHelper temperatureHelper = TemperatureHelper();
String? name;
String? temperature;
double? temperatureDouble;
String? childId;
String? uId;
int? isResponded;
String? age;
double? ageDouble;
String? alertWhen;
double? alertWhenDouble;


Future<void> initservice()async{
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var service=FlutterBackgroundService();
  //set for ios
  if(Platform.isIOS){
    await flutterLocalPlugin.initialize(const InitializationSettings(
      iOS: DarwinInitializationSettings()
    ));
  }

  await flutterLocalPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(notificationChannel);

  //service init and start
  await service.configure(
      iosConfiguration: IosConfiguration(
        onBackground: iosBackground,
        onForeground: onStart
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
       initialNotificationTitle: "background service",
        initialNotificationContent: "Temp Tracker",
      )
  );
  service.startService();
}

//onstart method
@pragma("vm:entry-point")
void onStart(ServiceInstance service){
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  DartPluginRegistrant.ensureInitialized();

  service.on("setAsForeground").listen((event) {
    print("foreground ===============");
  });

  service.on("setAsBackground").listen((event) {
    print("background ===============");
  });

  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  //display notification as service
  Timer.periodic(Duration(seconds: 3), (timer) async {
   await fetchChildrenData();

    temperatureDouble = double.tryParse(temperature ?? "0.0") ?? 0.0;
    ageDouble = double.tryParse(age ?? "0.0") ?? 0.0;
    alertWhenDouble =  double.tryParse(alertWhen?? "0.0") ?? 0.0;
// the responded field wil be changed to 0 if the sms is sent by HW
// if it was responded by the user then a function here is going to change the value into 0 after 15 second
    if (temperatureDouble!  >= alertWhenDouble! && isResponded! == 0) {
   homeController.storeDataInFirestore(childId!, name!, temperatureDouble!);
      homeController.storeAlertsInFirestore(childId!, name!, temperatureDouble!, uId!);

   homeController.changeTime(childId!);

    flutterLocalPlugin.show(
        90,
        "Warning",
        "High temperature detected for $name, Current temperature: ${temperatureDouble}°C' !!",
        NotificationDetails(android:AndroidNotificationDetails('temperature_alerts',"Warning",icon: "logo")        )
        
        );
}
 else if (temperatureDouble! < alertWhenDouble! && isResponded == 1){
FirebaseDatabase.instance
          .reference()
          .child("Children")
    .child(childId!)
          .update({"responded": 0});
}

// else if (temperatureDouble! < upperLimit && isResponded == 2){
// FirebaseDatabase.instance
//           .reference()
//           .child("Children")
//     .child(childId!)
//           .update({"responded": 0});
// }
    
  });
  print("Background service ${DateTime.now()}") ;


}

//iosbackground
@pragma("vm:entry-point")
Future<bool> iosBackground(ServiceInstance service)async{
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

Future<void> fetchChildrenData() async {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('Children');
  
  // Use once() to get a single DatabaseEvent
  DatabaseEvent event = await databaseReference.once();

  // Access the snapshot from the event
  DataSnapshot snapshot = event.snapshot;

  // Check if there is any data
  if (snapshot.value != null) {
    // Change the type cast to handle a more general case
    Map<dynamic, dynamic> childrenData = snapshot.value as Map<dynamic, dynamic>;

    // Loop through each child
    childrenData.forEach((childKey, child) {
      // Extract and store the relevant information for each child
      name = child['name'];
  temperature = child['temperature'];
  childId =child['id'];
  isResponded = child['responded'];
  age = child['age'];
  uId = child['uId'];
 alertWhen  = child['alertWhen'];

      // Do something with the data, such as storing it in a list or printing it
      print('Child: $name, Temperature: $temperature, ID: $childId, Responded: $isResponded, Age: $age, UID: $uId');
    });
    
  } else {
    // Handle the case where there is no data
    print('No data available for children.');
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Temp Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.FRONTPAGE,
      getPages: AppPages.routes,
    );
  }
}
