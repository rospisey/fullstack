import 'package:shared_preferences/shared_preferences.dart';

import 'database_provider.dart';

class StorageManager {
  static SharedPreferences? sharedPreferences;
  static FirestoreDatabase? firestoreDatabase;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    firestoreDatabase = FirestoreDatabase();
  }
}
