import 'package:allkhmerbook/auth/email_sign_in/next_screen.dart';
import 'package:allkhmerbook/auth/landing_page.dart';
import 'package:allkhmerbook/auth/service/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckVerifyEmail extends StatefulWidget {
  @override
  _CheckVerifyEmailState createState() => _CheckVerifyEmailState();
}

class _CheckVerifyEmailState extends State<CheckVerifyEmail> {
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  checkMailVerify(BuildContext context) async {
    try {
      _toggleLoading();
      final provider = Provider.of<BaseAuth>(context, listen: false);
      final user = provider.getCurrentUser();
      await user.reload();
      // Future.delayed(Duration(milliseconds: 3), () async {
      //   if (user.emailVerified) {
      //     await nextscreenNoBack(context, LandingPage());
      //   } else {
      //     _toggleLoading();
      //   }
      // });
      await nextscreenNoBack(context, LandingPage());

      _toggleLoading();
    } catch (e) {
      _toggleLoading();
      print('Error:$e');
    }
  }

  signout() async {
    final provider = Provider.of<BaseAuth>(context, listen: false);
    await provider.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        TextButton(onPressed: signout, child: Text('Log out')),
        Center(
          child: Text('please check email to verify'),
        ),
        TextButton(
            onPressed: () => checkMailVerify(context),
            child: _isLoading ? CircularProgressIndicator() : Text('Check')),
      ],
    ));
  }
}
