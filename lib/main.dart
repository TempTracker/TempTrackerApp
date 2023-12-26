import 'dart:async';

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

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
 //await initializeFirebase();
   //  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

   await initializeService();

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

Future<void> initializeService() async {
  Firebase.initializeApp(); 
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeLocalNotifications();
  final service = FlutterBackgroundService();


  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,

      autoStartOnBoot: true,
      onStart: _onStart,  
      isForegroundMode: true,
    ),
  );
 
}

void _onStart(ServiceInstance service) {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Firebase.initializeApp();
  Timer.periodic(const Duration(seconds: 15), (timer) async {
   fetchChildrenData();

    temperatureDouble = double.tryParse(temperature ?? "0.0") ?? 0.0;
    ageDouble = double.tryParse(age ?? "0.0") ?? 0.0;

  double upperLimit = temperatureHelper.getTemperatureLimit(ageDouble!);

    if (temperatureDouble! > upperLimit && isResponded! == 0) {
   homeController.storeDataInFirestore(childId!, name!, temperatureDouble!);
   homeController.changeTime(childId!);
 sendLocalNotification();
}
    print('Data retreived from  realtime: $name and his temperature is $temperature');

  
  });
}

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
 void sendLocalNotification() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'temptracker',
    'Your Channel Name',
    description: 'Your Channel Description',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'temptracker',
    'Your Channel Name',
    importance: Importance.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
  
    'Temperature Warning',
                           'High temperature detected for $name!. Current temperature: ${temperatureDouble}°C',
    platformChannelSpecifics,
  );
}

Future<void> initializeLocalNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const InitializationSettings initializationSettings =
      InitializationSettings(android: AndroidInitializationSettings('logo'));

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
