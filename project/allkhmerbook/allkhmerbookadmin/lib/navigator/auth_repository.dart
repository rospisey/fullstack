import 'package:pisey_services/pisey_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _AUTH_KEY = 'AuthKey';

class AuthRepository {
  Future<bool> isUserLoggedIn() async =>
      Future.delayed(Duration(seconds: 2)).then((value) {
        return StorageManager.sharedPreferences!.getBool(
              _AUTH_KEY,
            ) ??
            false;
      });

  Future<bool> _updateLoginStatus(bool loggedIn) async =>
      Future.delayed(Duration(seconds: 2)).then((value) async {
        bool pref = await StorageManager.sharedPreferences!
            .setBool(_AUTH_KEY, loggedIn);
        return pref;
      });

  Future<bool> logout() => _updateLoginStatus(false);

  Future<bool> login() => _updateLoginStatus(true);
}
