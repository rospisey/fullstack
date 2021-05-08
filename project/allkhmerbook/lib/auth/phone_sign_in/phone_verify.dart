import 'package:allkhmerbook/auth/service/api_path.dart';
import 'package:allkhmerbook/auth/service/auth_provider.dart';
import 'package:allkhmerbook/auth/service/firestore_service.dart';
import 'package:allkhmerbook/auth/service/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:provider/provider.dart';

class PhoneVerifyPage extends StatefulWidget {
  final String? verificationId;
  final String? phoneNumber;

  const PhoneVerifyPage({Key? key, this.verificationId, this.phoneNumber})
      : super(key: key);
  @override
  _PhoneVerifyPageState createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  final TextEditingController _smsController = TextEditingController();
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BaseAuth>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Color(0xFF3594DD),
              Color(0xFF4563DB),
              Color(0xFF5036D5),
              Color(0xFF5B16D0),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              headerSignIn(title: 'Phone Verify', isLoading: _isLoading),
              rowAlign(
                align: RowAlign.center,
                flex2: 6,
                child: PinCodeTextField(
                  appContext: context,
                  controller: _smsController,
                  autoDisposeControllers: false,
                  length: 6,
                  backgroundColor: Color(0xFF4563DB),
                  // fieldWidth: 40,
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  textStyle: TextStyleHelper.kSubtitleStyle,
                  onChanged: (String value) => () {},
                ),
              ),
              Divider(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              rowAlign(
                  align: RowAlign.center,
                  flex2: 1,
                  child: circleButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              try {
                                _toggleLoading();
                                await provider
                                    .signInWithPhoneNumber(
                                        widget.verificationId!,
                                        _smsController.text)
                                    .then((user) async {
                                  await FirestoreService.instance.setData(
                                      APIpath.setUsersPath(
                                          docUserID: user.uid!),
                                      {
                                        'email': widget.phoneNumber,
                                      });
                                  await StorageManager.sharedPreferences!
                                      .setString('uid', user.uid!);
                                  String uid = StorageManager.sharedPreferences!
                                      .getString('uid')!;
                                  print(uid);
                                  Navigator.of(context).pop();
                                  return user;
                                });
                              } catch (e) {
                                print(e);
                                _toggleLoading();
                              }
                            },
                      icons: FontAwesomeIcons.fan,
                      title: 'Verify')),
            ],
          ),
        ),
      ),
    );
  }
}

Widget rowAlign(
    {@required RowAlign? align,
    @required Widget? child,
    int? flex1,
    int? flex2,
    int? flex3}) {
  return Row(children: buildAlign(align!, child!, flex1, flex2, flex3));
}

enum RowAlign { left, center, right }

List<Widget> buildAlign(
  RowAlign align,
  Widget child,
  flex1,
  int? flex2,
  int? flex3,
) {
  if (align == RowAlign.left) {
    return [
      Expanded(flex: flex1 ?? 1, child: child),
      Spacer(
        flex: flex2 ?? 1,
      ),
      Spacer(
        flex: flex3 ?? 1,
      )
    ];
  } else if (align == RowAlign.right) {
    return [
      Spacer(
        flex: flex1 ?? 1,
      ),
      Spacer(
        flex: flex2 ?? 1,
      ),
      Expanded(flex: flex3 ?? 1, child: child),
    ];
  } else {
    return [
      Spacer(
        flex: flex1 ?? 1,
      ),
      Expanded(flex: flex2 ?? 1, child: child),
      Spacer(
        flex: flex3 ?? 1,
      ),
    ];
  }
}

Widget headerSignIn({String? title, bool? isLoading}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image(
        image: AssetImage('assets/splash.png'),
        height: 130,
      ),
      SizedBox(
        height: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          isLoading!
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RichText(
                  text: TextSpan(
                    text: 'Sign In Now With ',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                          text: title,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
        ],
      ),
      Divider()
    ],
  );
}

Widget circleButton(
    {@required VoidCallback? onPressed, String? title, IconData? icons}) {
  return Container(
      height: 45,
      decoration: BoxDecoration(
          // color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(25)),
      child: FlatButton.icon(
          color: Colors.deepPurpleAccent,
          disabledColor: Colors.deepPurpleAccent,
          icon: Icon(
            icons,
            size: 22,
            color: Colors.orange,
          ),
          label: Text(
            title!,
            style: TextStyleHelper.kSubtitleStyle,
          ),
          onPressed: onPressed));
}

class TextStyleHelper {
  TextStyleHelper._();
  static const kBigTitleStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontSize: 40.0,
    height: 1,
  );

  static const kSubtitleStyle = TextStyle(
      color: Colors.white, fontSize: 16.0, height: 1.0, fontFamily: 'Poppins');
  static const kErrorTextStyle = TextStyle(
      color: Colors.orange, fontSize: 14.0, height: 1.0, fontFamily: 'Poppins');
}
