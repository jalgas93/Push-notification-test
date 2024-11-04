import 'package:flutter/cupertino.dart';

import 'application.dart';

class ChangeToken extends ChangeNotifier {
  String _token = "Initial Value";
  String _title = "Initial Value";
  String get token => _token;
  String get title => _title;
  void add(String token) async {
    await Application.sharedPreferences?.setString('fcmToken', token!);
    _token = token;
    notifyListeners();
  }

  void addTitle(String title) async {
    await Application.sharedPreferences?.setString('fcmTokenTitle', title);
    _title = title;
    notifyListeners();
  }
  void updateValue() {
    notifyListeners();
  }
}
