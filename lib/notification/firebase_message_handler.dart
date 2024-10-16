import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../global/application.dart';

class FirebaseMessageHandler {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );
  final _localNotification = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    print('messages ${message?.notification?.title}');
    if (message == null) return;
  }


}
