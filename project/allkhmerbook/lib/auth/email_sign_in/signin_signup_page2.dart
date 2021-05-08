import 'package:allkhmerbook/auth/model/user.dart';
import 'package:allkhmerbook/auth/phone_sign_in/phone_signin_page.dart';
import 'package:allkhmerbook/auth/phone_sign_in/phone_verify.dart';
import 'package:allkhmerbook/auth/service/auth_provider.dart';
import 'package:allkhmerbook/auth/service/storage_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage2 extends StatefulWidget {
  final GlobalKey<ScaffoldState>? snackbar;

  const SignInPage2({Key? key, this.snackbar}) : super(key: key);
  @override
  _SignInPage2State createState() => _SignInPage2State();
}

enum FormType {
  login,
  register,
}

class _SignInPage2State extends State<SignInPage2> {
  String? _email, _password, _username;

  final formkey = new GlobalKey<FormState>();

  FormType _formType = FormType.login;
  bool _obscureText = true;
  bool _isLoading = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> saveAndSubmit() async {
    if (validateAndSave()) {
      try {
        _toggleLoading();
        final provider = Provider.of<BaseAuth>(context, listen: false);
        if (_formType == FormType.login) {
          UserModel user =
              await provider.signInWithEmailAndPassword(_email!, _password!);
          await StorageManager.sharedPreferences!.setString('uid', user.uid!);
          String uid = StorageManager.sharedPreferences!.getString('uid')!;
          print(uid);
        } else {
          UserModel userID = await provider.createAccountWithEmailAndPassword(
              _email!, _password!);

          // await provider.setUserData(UserModel(
          //     uid: userID.uid,
          //     email: _email,
          //     name: _username,
          //     urlPhoto: defaultPic));
        }
      } catch (e) {
        widget.snackbar!.currentState!.showSnackBar(snackBar);
        _toggleLoading();
        final form = formkey.currentState;
        form!.reset();
      }
    }
  }

  void moveToRegister() {
    formkey.currentState!.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formkey.currentState!.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formkey,
        child: ListView(children: buidlUI() + buildInput() + buildButton()),
      ),
    );
  }

  List<Widget> buidlUI() {
    return [headerSignIn(title: 'Email', isLoading: _isLoading)];
  }

  List<Widget> buildInput() {
    if (_formType == FormType.login) {
      return [
        textField(
          key: Key('email'),
          hintText: "Email",
          onSaved: (value) => _email = value,
          validator: (value) => value!.isEmpty ? "'Email can't be empty" : null,
          keyboardType: TextInputType.emailAddress,
          isLoading: _isLoading,
        ),
        textField(
            key: Key('password'),
            hintText: "Password",
            obscureText: _obscureText,
            isLoading: _isLoading,
            onSaved: (value) => _password = value,
            suffix: FlatButton(
                onPressed: _toggle,
                child: Text(
                  _obscureText ? "Show" : "Hide",
                  style: TextStyleHelper.kSubtitleStyle,
                )),
            validator: (value) {
              if (value!.isEmpty) {
                return "'Password can't be empty";
              } else if (value.length < 8) {
                return "Password at least 8";
              }
              return null;
            }),
        SizedBox(
          height: 20,
        )
      ];
    } else {
      return [
        textField(
          key: Key('username'),
          hintText: "Username",
          onSaved: (value) => _username = value,
          isLoading: _isLoading,
          validator: (value) =>
              value!.isEmpty ? "'Username can't be empty" : null,
        ),
        textField(
            key: Key('email'),
            hintText: "Email",
            isLoading: _isLoading,
            onSaved: (value) => _email = value,
            validator: (value) =>
                value!.isEmpty ? "'Email can't be empty" : null,
            keyboardType: TextInputType.emailAddress),
        textField(
            key: Key('password'),
            hintText: "Password",
            isLoading: _isLoading,
            obscureText: _obscureText,
            suffix: FlatButton(
                onPressed: _toggle,
                child: Text(
                  _obscureText ? "Show" : "Hide",
                  style: TextStyleHelper.kSubtitleStyle,
                )),
            onSaved: (value) => _password = value,
            validator: (value) {
              if (value!.isEmpty) {
                return "'Password can't be empty";
              } else if (value.length < 8) {
                return "Password at least 8";
              }
              return null;
            }),
        SizedBox(
          height: 20,
        )
      ];
    }
  }

  List<Widget> buildButton() {
    if (_formType == FormType.login) {
      return [
        SizedBox(
          height: 40,
          child: new RaisedButton(
            // key: Key('signIn'),
            color: Colors.amberAccent,
            disabledColor: Colors.amberAccent,
            child: new Text(
              "Login",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: _isLoading ? null : saveAndSubmit,
          ),
        ),
        new FlatButton(
          child: Text(
            "Create new account",
            style: TextStyleHelper.kSubtitleStyle,
          ),
          onPressed: _isLoading ? null : moveToRegister,
        ),
      ];
    } else {
      return [
        SizedBox(
          height: 40,
          child: new RaisedButton(
            key: Key('create'),
            child: new Text(
              "Create new account",
              style: TextStyle(color: Colors.black),
            ),
            color: Colors.amberAccent,
            disabledColor: Colors.amberAccent,
            onPressed: _isLoading ? null : saveAndSubmit,
          ),
        ),
        new FlatButton(
          child: Text("Have an account, Login",
              style: TextStyleHelper.kSubtitleStyle),
          onPressed: _isLoading ? null : moveToLogin,
        )
      ];
    }
  }
}

SnackBar snackBar = SnackBar(
  content: Container(
    alignment: Alignment.centerLeft,
    height: 60,
    child: Text(
      'No internet connection available!',
      style: TextStyle(
        fontSize: 17,
      ),
    ),
  ),
  action: SnackBarAction(
    label: 'Try Again',
    textColor: Colors.blueAccent,
    onPressed: () {},
  ),
);
