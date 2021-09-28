import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously() async {
    try {
      UserCredential user = await FirebaseAuth.instance.signInAnonymously();
      String token = await user.user!.getIdToken();
      print('${token}');
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Center(
        child: RaisedButton(
          child: Text('Sign in anonymously'),
          onPressed: _signInAnonymously,
        ),
      ),
    );
  }
}
