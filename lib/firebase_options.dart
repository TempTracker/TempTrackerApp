
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      // case TargetPlatform.iOS:
      //   return ios;
      // case TargetPlatform.macOS:
      //   return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
   apiKey: 'AIzaSyBmzPGHFXvdKMgQdSsmmsnMQJFFs9ZLe1Q',
    appId: '1:526463425358:android:cda31667e5fda59ab2dc1f',
    databaseURL: "https://temptrackerapp-620a4-default-rtdb.firebaseio.com",
    messagingSenderId: '492798704115',
    projectId: 'temptrackerapp-620a4',
    storageBucket: 'temptrackerapp-620a4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmzPGHFXvdKMgQdSsmmsnMQJFFs9ZLe1Q',
    appId: '1:526463425358:android:cda31667e5fda59ab2dc1f',
    databaseURL: "https://temptrackerapp-620a4-default-rtdb.firebaseio.com",
    messagingSenderId: '492798704115',
    projectId: 'temptrackerapp-620a4',
    storageBucket: 'temptrackerapp-620a4.appspot.com',
  );  

}
