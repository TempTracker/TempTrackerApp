import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:temp_tracker/controller/home_controller.dart';
import 'package:temp_tracker/firebase_options.dart';
import 'package:temp_tracker/helper/temperatureHelper.dart';
import 'package:temp_tracker/routes/app_pages.dart';
import 'helper/git_di.dart' as di;



final FlutterLocalNotificationsPlugin flutterLocalPlugin =FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel notificationChannel=AndroidNotificationChannel(
    "Warning",
    "this temperature is very high ",
    description: "This is channel des....",
  importance: Importance.high
);

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
 //await initializeFirebase();
   //  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

 //  await initializeService();
 Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 await initservice();
  await di.init();


  runApp(const MyApp());


}
HomeController homeController =  HomeController();
TemperatureHelper temperatureHelper = TemperatureHelper();
String? name;
String? temperature;
double? temperatureDouble; 
String? childId;
int? isResponded;
String? age;
double? ageDouble;



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
      //  notificationChannelId: "coding is life",//comment this line if show white screen and app crash
        initialNotificationTitle: "background service",
        initialNotificationContent: "Temp Tracker",
        foregroundServiceNotificationId: 90
      )
  );
  service.startService();

  //for ios enable background fetch from add capability inside background mode

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
  Timer.periodic(Duration(seconds: 10), (timer) {
   fetchChildrenData();

    temperatureDouble = double.tryParse(temperature ?? "0.0") ?? 0.0;
    ageDouble = double.tryParse(age ?? "0.0") ?? 0.0;

  double upperLimit = temperatureHelper.getTemperatureLimit(ageDouble!);

    if (temperatureDouble! > upperLimit && isResponded! == 0) {
   homeController.storeDataInFirestore(childId!, name!, temperatureDouble!);
   homeController.changeTime(childId!);

    flutterLocalPlugin.show(
        90,
        "Warning",
        "High temperature detected for $name, Current temperature: ${temperatureDouble}°C' !!,",
     
     
        NotificationDetails(android:AndroidNotificationDetails("background service","coding is life service",icon: "logo")));
}
 
    
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

// Future<void> initializeService() async {
//   Firebase.initializeApp(); 
//   Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   initializeLocalNotifications();
//   final service = FlutterBackgroundService();


//   await service.configure(
//     iosConfiguration: IosConfiguration(),
//     androidConfiguration: AndroidConfiguration(
//       autoStart: true,

//       autoStartOnBoot: true,
//       onStart: _onStart,  
//       isForegroundMode: true,
//     ),
//   );
 
// }

// void _onStart(ServiceInstance service) {
//   Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   Firebase.initializeApp();
//   Timer.periodic(const Duration(seconds: 15), (timer) async {
//    fetchChildrenData();

//     temperatureDouble = double.tryParse(temperature ?? "0.0") ?? 0.0;
//     ageDouble = double.tryParse(age ?? "0.0") ?? 0.0;

//   double upperLimit = temperatureHelper.getTemperatureLimit(ageDouble!);

//     if (temperatureDouble! > upperLimit && isResponded! == 0) {
//    homeController.storeDataInFirestore(childId!, name!, temperatureDouble!);
//    homeController.changeTime(childId!);
//  sendLocalNotification();
// }
//     print('Data retreived from  realtime: $name and his temperature is $temperature');

  
//   });
// }

Future<void> fetchChildrenData() async {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('Children');
  DataSnapshot snapshot = await databaseReference.child("-NmIAiq4RX_ouuyWTYxL").get();

  Map child = snapshot.value as Map;

  // Store the fetched name in the variable
  name = child['name'];
  temperature = child['temperature'];
  childId =child['id'];
  isResponded = child['responded'];
  age = child['age'];
  

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
