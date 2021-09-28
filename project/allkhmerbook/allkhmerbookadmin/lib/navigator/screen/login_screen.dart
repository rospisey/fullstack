import 'package:allkhmerbookadmin/navigator/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends ViewModelWidget<AuthViewModel> {
  final VoidCallback onLogin;
  const LoginScreen(this.onLogin, {Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, AuthViewModel model) {
    return Scaffold(
      body: Center(
        child: model.logingIn
            ? Text('Logging In')
            : ElevatedButton(
                onPressed: () async {
                  final result = await model.login();
                  if (result == true) {
                    onLogin();
                  } else {
                    model.logingIn = false;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Log in'),
                ),
              ),
      ),
    );
  }
}
