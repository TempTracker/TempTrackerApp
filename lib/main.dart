import 'dart:async';

import 'dart:io';
import 'dart:ui';

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

 //Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 await initservice();
  await di.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());


}

//تم استخدام دوال من هذه الكلاسات
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
int? emailsNum;

// دالة تشغيل التطبيق في الخلفية
Future<void> initservice()async{
  //تشغيل الفايربيز
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




//الدالة التي تحتوي على جميع العمليات التي تعمل في الخلفية
@pragma("vm:entry-point")
void onStart(ServiceInstance service) async{
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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

// الدالة المسؤوله عن الاستعلام عن عدد الايميلات التي تم رفعها من قبل الهاردوير 
DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('Children');

int? previousEmailsNum; // Variable to store the previous value of emailsNum

databaseReference.onValue.listen((event) {
  DataSnapshot snapshot = event.snapshot;

  if (snapshot.value != null) {
    Map<dynamic, dynamic> childrenData = snapshot.value as Map<dynamic, dynamic>;

    childrenData.forEach((childKey, child) {
      int currentEmailsNum = child['emailsNum'] ?? 0; // Default to 0 if emailsNum is not present

      if (currentEmailsNum != previousEmailsNum) {
        // The emailsNum field has changed
        print('emailsNum changed for $name: $previousEmailsNum -> $currentEmailsNum');

   alertsController.updateDataInFirestore(childId, currentEmailsNum);
        // Update the previous value
        previousEmailsNum = currentEmailsNum;
      }
    });
  } else {
    print('No data available for children.');
  }
});






// دالة تعمل كل ثانية لفحص درجة حرارة الطفل اذا كانت اقل من 30 يعني ان الاسوارة تمت ازالتها 
Timer.periodic(Duration(seconds: 1), (timer) async {

String? temperatureForBracelet;
DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('Children');
    DatabaseEvent event = await databaseReference.once();
  DataSnapshot snapshot = event.snapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> childrenData = snapshot.value as Map<dynamic, dynamic>;

    childrenData.forEach((childKey, child) {
      name = child['name'];
  temperatureForBracelet = child['temperature'];
    });
  } else {
    print('No data available for children.');
  }
 double temperatureDoubleForBracelet = double.tryParse(temperatureForBracelet ?? "0.0") ?? 0.0;

if (temperatureDoubleForBracelet! < 30 && temperatureDoubleForBracelet != 0.0){

  // ارسال الاشعار
flutterLocalPlugin.show(
        90,
        "Bracelet Removal Warning",
         "$name's bracelet has been removed. Please check on them!",
        NotificationDetails(android:AndroidNotificationDetails('temperature_alerts',"Warning",icon: "logo")        )
        
        );
// تخزين حالة ضياع الساعة
     alertsController.storeBraceletAlertsInFirestore(childId!, name!, uId!);
}
});



// الدالة التي تستعلم عن درجة الحرارة كل 20 ثانية وفحص اذا تعدت درجة الحرارة التي وضعتها الام او تعدت المعيار العالمي 
  Timer.periodic(Duration(seconds: 20), (timer) async {
   await fetchChildrenData();

    temperatureDouble = double.tryParse(temperature ?? "0.0") ?? 0.0;
    ageDouble = double.tryParse(age ?? "0.0") ?? 0.0;
    alertWhenDouble =  double.tryParse(alertWhen?? "0.0") ?? 0.0;
    double upperLimit = temperatureHelper.getTemperatureLimit(ageDouble!);
// the responded field wil be changed to 0 if the sms is sent by HW

    if (temperatureDouble!  >= alertWhenDouble! && isResponded! == 0 && alertWhenDouble != 0.0 ) {

  homeController.storeAlertsInFirestore(childId!, name!, temperatureDouble!, uId!);
  homeController.changeTime(childId!);

    flutterLocalPlugin.show(
        90,
        "Warning",
        "High temperature detected for $name, Current temperature: ${temperatureDouble}°C' !!",
        NotificationDetails(android:AndroidNotificationDetails('temperature_alerts',"Warning",icon: "logo")        )
        
        );
} else if (temperatureDouble!  >= upperLimit! && isResponded! == 0 && alertWhenDouble != 0.0 ){

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
 else if (temperatureDouble! < upperLimit! && isResponded == 1){
FirebaseDatabase.instance
          .reference()
          .child("Children")
    .child(childId!)
          .update({"responded": 0});
}
 else if (temperatureDouble! < alertWhenDouble! && isResponded == 1){
FirebaseDatabase.instance
          .reference()
          .child("Children")
    .child(childId!)
          .update({"responded": 0});
}
 else if ( alertWhenDouble == 0 && isResponded == 1){
FirebaseDatabase.instance
          .reference()
          .child("Children")
    .child(childId!)
          .update({"responded": 0});
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


// دالة الاستعلام التي تم استخدامها في الدالة التي تعمل كل 20 ثانية 
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
 emailsNum = child['emailsNum'];
  
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
