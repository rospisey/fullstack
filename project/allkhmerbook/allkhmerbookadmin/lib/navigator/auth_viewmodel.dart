import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'auth_repository.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository authRepository = locator<AuthRepository>();
  bool logingIn = false;
  bool logingOut = false;

  // bool? _loggedIn;
  // bool? get loggedIn => _loggedIn;
  // void setloggedIn(value) {
  //   _loggedIn = value;
  //   notifyListeners();
  // }

  Future<bool> login() async {
    logingIn = true;
    notifyListeners();
    final _loggedIn = await authRepository.login();
    logingIn = false;
    notifyListeners();
    return _loggedIn;
  }

  Future<bool> logout() async {
    logingOut = true;
    notifyListeners();
    final _loggedIn = await authRepository.logout();
    logingOut = false;
    notifyListeners();
    return _loggedIn;
  }
}
