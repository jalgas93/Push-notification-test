import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'global/application.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );
  final _localNotification = FlutterLocalNotificationsPlugin();
  String? token = "";
  RemoteMessage? messageText;

  void handleMessage(RemoteMessage? message) {
    print('messages ${message?.notification?.title}');
    if (message == null) return;
    messageText = message;
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

    token = await _firebaseMessaging.getToken();
    print('token ${token}');
    await Application.sharedPreferences?.setString('fcmToken', token!);
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

  @override
  void initState() {
    startApplication();
    super.initState();
  }

  Future<void> startApplication() async {
    await _firebaseMessaging.getToken();
    //await Application.firebaseMessageHandler.initNotification();
    await Application.setupSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push notification test"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Title:${messageText?.notification?.title}',
                    maxLines: 10,
                    textAlign: TextAlign.start,
                  )
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                          "Your token:$token",
                          maxLines: 10,
                          textAlign: TextAlign.start,
                        ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              height: 45,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    initNotification();
                    setState(() {});
                  },
                  child: const Text(
                    "Get token",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
