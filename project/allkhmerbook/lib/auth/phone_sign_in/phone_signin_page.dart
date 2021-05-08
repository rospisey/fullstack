import 'package:allkhmerbook/auth/model/user.dart';
import 'package:allkhmerbook/auth/service/api_path.dart';
import 'package:allkhmerbook/auth/service/auth_provider.dart';
import 'package:allkhmerbook/auth/service/firestore_service.dart';
import 'package:allkhmerbook/auth/service/storage_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'phone_verify.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => new _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController _smsController = TextEditingController();

  // String _message = '';
  String? _verificationId;
  String? _phoneNumber;
  String? _countryCode;
  bool _isLoading = false;
  UserModel? _user;

  final formkey = new GlobalKey<FormState>();
  bool validateAndSave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> saveAndSubmit(BaseAuth provider) async {
    if (validateAndSave()) {
      try {
        _toggleLoading();
        await _verifyPhoneNumber(provider);
      } catch (e) {
        print(e);
        _toggleLoading();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BaseAuth>(context);
    // final alluser = Provider.of<User>(context);
    return Form(
      key: formkey,
      child: ListView(
        children: <Widget>[
          headerSignIn(title: 'Phone', isLoading: _isLoading),
          rowAlign(
            align: RowAlign.center,
            child: CountryCodePicker(
              onChanged: (value) {
                _countryCode = value.dialCode;
              },
              initialSelection: ('KH'),
              favorite: ['KH'],
              showFlag: true,
              // countryFilter: ['IT', 'FR'],
              showFlagDialog: false,
              textStyle: TextStyleHelper.kSubtitleStyle,
              comparator: (a, b) => b.name!.compareTo(a.name!),
              onInit: (code) => _countryCode = code!.dialCode,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: textField(
                key: Key('Phone'),
                hintText: "Phone",
                isLoading: _isLoading,
                onSaved: (value) => _phoneNumber = value,
                validator: (value) =>
                    value!.isEmpty ? "'Phone Number can't be empty" : null,
                keyboardType: TextInputType.number),
          ),
          SimpleRoundIconButton(
            onPressed: _isLoading ? null : () => saveAndSubmit(provider),
            backgroundColor: Colors.deepPurpleAccent,
            disableColor: Colors.deepPurpleAccent,
            buttonText: Text(
              'Get SMS',
              style: TextStyleHelper.kSubtitleStyle,
            ),
            icon: Icon(FontAwesomeIcons.sms),
          ),
        ],
      ),
    );
  }

  // Example code of how to verify phone number
  Future<void> _verifyPhoneNumber(BaseAuth provider) async {
    // setState(() {
    //   _message = '';
    // });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      await provider.verifyPhoneNumber(phoneAuthCredential).then((user) async {
        await FirestoreService.instance
            .setData(APIpath.setUsersPath(docUserID: user.uid), {
          'email': '$_countryCode$_phoneNumber',
        });
        await StorageManager.sharedPreferences!.setString('uid', user.uid!);
        String uid = StorageManager.sharedPreferences!.getString('uid')!;
        print(uid);
        return user;
      });

      //     .then((user) async {
      //   print(user.name);
      //   if (user.uid != null) {
      //     await provider.setUserData(User(
      //         uid: user.uid,
      //         email: '$_countryCode$_phoneNumber',
      //         ));
      //   }
      //   return user;
      // }
      // );
      // setState(() {
      //   _message = 'Received phone auth credential: $phoneAuthCredential';
      // });
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      // setState(() {
      //   _message =
      //       'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      // });
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text('Phone number verification failed. Please try again!'),
      ));
    };

    final PhoneCodeSent codeSent =
        (String? verificationId, [int? forceResendingToken]) async {
      // Scaffold.of(context).showSnackBar(const SnackBar(
      //   content: Text('Please check your phone for the verification code.'),
      // ));
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PhoneVerifyPage(
                verificationId: verificationId,
                phoneNumber: _phoneNumber,
              )));
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: '$_countryCode$_phoneNumber',
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}

class SimpleRoundIconButton extends StatelessWidget {
  final Color backgroundColor;
  final Text buttonText;
  final Color textColor;
  final Color? disableColor;
  final Icon icon;
  final Color? iconColor;
  final Alignment iconAlignment;
  final void Function()? onPressed;

  SimpleRoundIconButton(
      {this.backgroundColor = Colors.redAccent,
      this.buttonText = const Text("REQUIRED TEXT"),
      this.textColor = Colors.white,
      this.icon = const Icon(Icons.email),
      this.iconColor,
      this.iconAlignment = Alignment.centerLeft,
      this.onPressed,
      this.disableColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              splashColor: this.backgroundColor,
              color: this.backgroundColor,
              disabledColor: disableColor,
              child: new Row(
                children: <Widget>[
                  iconAlignment == Alignment.centerLeft
                      ? new Transform.translate(
                          offset: Offset(-10.0, 0.0),
                          child: new Container(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(28.0)),
                              splashColor: Colors.white,
                              color: Colors.white,
                              child: Icon(
                                icon.icon,
                                color: iconColor == null
                                    ? backgroundColor
                                    : iconColor,
                              ),
                              onPressed: () => {},
                            ),
                          ),
                        )
                      : Container(),
                  iconAlignment == Alignment.centerLeft
                      ? new Expanded(
                          child: Container(),
                        )
                      : Container(),
                  new Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                    child: buttonText,
                  ),
                  iconAlignment == Alignment.centerRight
                      ? new Expanded(
                          child: Container(),
                        )
                      : Container(),
                  iconAlignment == Alignment.centerRight
                      ? new Transform.translate(
                          offset: Offset(10.0, 0.0),
                          child: new Container(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(28.0)),
                              splashColor: Colors.white,
                              color: Colors.white,
                              child: Icon(
                                icon.icon,
                                color: iconColor == null
                                    ? backgroundColor
                                    : iconColor,
                              ),
                              onPressed: () => {},
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}

Widget textField(
    {FormFieldSetter<String>? onSaved,
    String? hintText,
    FormFieldValidator<String>? validator,
    bool? obscureText,
    bool? isLoading,
    Widget? suffix,
    TextInputType? keyboardType,
    Key? key}) {
  return new TextFormField(
    enabled: isLoading! ? false : true,
    key: key,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        hintText: hintText,
        hintStyle: TextStyleHelper.kSubtitleStyle,
        labelStyle: TextStyleHelper.kSubtitleStyle,
        suffix: suffix,
        errorStyle: TextStyleHelper.kErrorTextStyle),
    validator: validator,
    onSaved: onSaved,
    keyboardType: keyboardType,
    obscureText: obscureText ?? false,
    style: TextStyleHelper.kSubtitleStyle,
  );
}
