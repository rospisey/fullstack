import 'package:allkhmerbookadmin/navigator/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LogoutScreen extends ViewModelWidget<AuthViewModel> {
  final VoidCallback onLogout;
  const LogoutScreen(this.onLogout, {Key? key})
      : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, AuthViewModel model) {
    return Scaffold(
      body: Center(
        child: model.logingOut
            ? Text('Logging out')
            : ElevatedButton(
                onPressed: () async {
                  final result = await model.logout();
                  if (result == true) {
                    onLogout();
                  } else {
                    model.logingIn = false;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Log out'),
                ),
              ),
      ),
    );
  }
}
