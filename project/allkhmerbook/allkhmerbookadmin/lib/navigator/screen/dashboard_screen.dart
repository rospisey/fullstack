import 'package:allkhmerbookadmin/navigator/auth_repository.dart';
import 'package:allkhmerbookadmin/navigator/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DashboardScreen extends ViewModelWidget<AuthViewModel> {
  const DashboardScreen({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, AuthViewModel model) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Dashboard ${model.logingOut}'),
          onPressed: () => model.logout(),
        ),
      ),
    );
  }
}
