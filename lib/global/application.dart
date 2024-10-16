import 'package:notification/global/shared_preference_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notification/firebase_message_handler.dart';

class Application {
  Application._();

  // Shared Prefs
  static SharedPreferences? get sharedPreferences => _sharedPreferences;
  static SharedPreferences? _sharedPreferences; // Shared Preferences

  static Future<void> setupSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static FirebaseMessageHandler firebaseMessageHandler =
      FirebaseMessageHandler();
}
