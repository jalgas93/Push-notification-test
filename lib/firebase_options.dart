// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDB8HcNR0KPdRzDsJGFj7DnE1yqWgc1LC0',
    appId: '1:620039441249:web:29a278170f436e4a25d320',
    messagingSenderId: '620039441249',
    projectId: 'push-notification-ff9d8',
    authDomain: 'push-notification-ff9d8.firebaseapp.com',
    storageBucket: 'push-notification-ff9d8.appspot.com',
    measurementId: 'G-V4B7DQPQ99',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAFYdatMs5tCzSjg0mZrTztS-B6pFdGEU',
    appId: '1:620039441249:android:a2a6e9818d901a8125d320',
    messagingSenderId: '620039441249',
    projectId: 'push-notification-ff9d8',
    storageBucket: 'push-notification-ff9d8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_wIAE4pF6h3hCTgzvG6339V9Ks0i6y3E',
    appId: '1:620039441249:ios:0b7d8ba55d229d9c25d320',
    messagingSenderId: '620039441249',
    projectId: 'push-notification-ff9d8',
    storageBucket: 'push-notification-ff9d8.appspot.com',
    iosBundleId: 'com.push.notification',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_wIAE4pF6h3hCTgzvG6339V9Ks0i6y3E',
    appId: '1:620039441249:ios:0b7d8ba55d229d9c25d320',
    messagingSenderId: '620039441249',
    projectId: 'push-notification-ff9d8',
    storageBucket: 'push-notification-ff9d8.appspot.com',
    iosBundleId: 'com.push.notification',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDB8HcNR0KPdRzDsJGFj7DnE1yqWgc1LC0',
    appId: '1:620039441249:web:64e8c058b200b43225d320',
    messagingSenderId: '620039441249',
    projectId: 'push-notification-ff9d8',
    authDomain: 'push-notification-ff9d8.firebaseapp.com',
    storageBucket: 'push-notification-ff9d8.appspot.com',
    measurementId: 'G-9YTRFESEMF',
  );
}
