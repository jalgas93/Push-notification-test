import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/global/change_token.dart';

import '../global/application.dart';
import '../global/shared_preference_key.dart';

// @pragma('vm:entry-point')
// Future<void> _handleBackgroundMessage(RemoteMessage message) async {
// // Если вы собираетесь использовать другие службы Firebase в фоновом режиме, такие как Firestone,
// // убедитесь, что вы вызываете "инициализировать приложение", прежде чем использовать другие службы Firebase.
//
//   print("Handling a background message: ${message.messageId}");
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }

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
    if (message?.notification?.title != null) {
      ChangeToken().addTitle(message.notification!.title!);
    }
  }

  Future initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: '@drawable/launch_background'),
          ),
          payload: jsonEncode(message.toMap()));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    final token = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print('token $token');
    }
    ChangeToken().add(token!);
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android =
        AndroidInitializationSettings('@drawable/launch_background');
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotification.initialize(settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      final message =
          RemoteMessage.fromMap(jsonDecode(notificationResponse.payload!));
      handleMessage(message);
    });

    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    initPushNotifications();
    initLocalNotifications();
  }
}
