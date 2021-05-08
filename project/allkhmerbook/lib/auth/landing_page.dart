import 'package:allkhmerbook/auth/email_sign_in/email_verify.dart';
import 'package:allkhmerbook/auth/model/user.dart';
import 'package:allkhmerbook/auth/signin_view.dart';
import 'package:allkhmerbook/myhomepage.dart';
import 'package:flutter/material.dart';
import 'service/auth_provider.dart';
import 'email_sign_in/sign_in1.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BaseAuth>(context);
    return StreamBuilder<UserModel>(
        stream: provider.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            UserModel? user = snapshot.data;
            if (user == null) {
              return SignInPageView();
            }
            if (!user.emailVerified!) {
              return CheckVerifyEmail();
            } else
              return MyHomePage(
                platform: Theme.of(context).platform,
                title: 'Flutter Download',
              );
            // return BaseModel(
            //   create: FirestoreDatabase().streamData(),
            //   builder: (context, list, child) {
            //     if (list == null) {
            //       return Center(child: CircularProgressIndicator());
            //     } else {
            //       return MyHome();
            //     }
            //   },
            // );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
