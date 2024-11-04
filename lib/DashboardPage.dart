import 'package:flutter/material.dart';
import 'package:notification/global/change_token.dart';
import 'package:provider/provider.dart';

import 'global/application.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    startApplication();
    super.initState();
  }

  Future<void> startApplication() async {
    await Application.firebaseMessageHandler.initNotification();
    await Application.setupSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push notification test"),
        centerTitle: true,
      ),
      body: Consumer<ChangeToken>(
        builder: (BuildContext context, data, widget) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (Application.sharedPreferences?.get("fcmTokenTitle") !=
                        null)
                      Flexible(
                          child: Text(
                        'Title:${Application.sharedPreferences?.get("fcmTokenTitle")}',
                        maxLines: 10,
                        textAlign: TextAlign.start,
                      )),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (Application.sharedPreferences?.get("fcmToken") != null)
                      Flexible(
                        child: Text(
                          "Your token:${Application.sharedPreferences?.get("fcmToken")}",
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
                        data.updateValue();
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
          );
        },
        child: const Text('Update Value'),
      ),
    );
  }
}
