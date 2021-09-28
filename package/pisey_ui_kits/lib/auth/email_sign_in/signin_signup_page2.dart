part of pisey_ui_kits;

class SignInPage2 extends StatefulWidget {
  final GlobalKey<ScaffoldState>? snackbar;

  const SignInPage2({
    Key? key,
    this.snackbar,
  }) : super(key: key);
  @override
  _SignInPage2State createState() => _SignInPage2State();
}

enum FormType {
  login,
  register,
}

class _SignInPage2State extends State<SignInPage2> {
  String? _email, _password, _username;
  final FirestoreService _firestoreService =
      StackedLocator.instance.locator<FirestoreService>();
  final RealTimeService _realtimeService =
      StackedLocator.instance.locator<RealTimeService>();
  final DialogService _snackbarService =
      StackedLocator.instance.locator<DialogService>();

  final formkey = new GlobalKey<FormState>();

  FormType _formType = FormType.login;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextInputType keyInput = TextInputType.name;

  toggleInput() {}

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> saveAndSubmit(SignInViewModel auth) async {
    if (validateAndSave()) {
      if (_formType == FormType.login) {
        var user = await auth.signInAccEmail(_email!, _password!);
        if (user != null) {
          _firestoreService.updateData('users/${user.user!.uid}', {
            'presence': true,
            'lastSeenInEpoch': DateTime.now().millisecondsSinceEpoch,
          }).catchError((onError) {
            auth.setBusy(false);
            _snackbarService.showDialog(
                title: 'Firestore Error', description: '$onError');
          });
        }
      } else {
        auth.setBusy(true);
        var user = await auth
            .createAccEmail(_email!, _password!)
            .catchError((onError) {
          auth.setBusy(false);
          _snackbarService.showDialog(
              title: 'Account Error', description: '$onError');
        });

        if (user != null) {
          _firestoreService.setData('users/${user.user!.uid}', {
            'username': _username,
            'mail': _email,
            'createdTime': DateTime.now().millisecondsSinceEpoch,
            'presence': false,
            'lastSeenInEpoch': DateTime.now().millisecondsSinceEpoch,
            'role': 'member'
          }).catchError((onError) {
            auth.setBusy(false);
            _snackbarService.showDialog(
                title: 'Database Error', description: '$onError');
          });
        }
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
    return ViewModelBuilder<SignInViewModel>.reactive(
        builder: (context, auth, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formkey,
              child: ListView(
                  children:
                      buidlUI(auth) + buildInput(auth) + buildButton(auth)),
            ),
          );
        },
        viewModelBuilder: () => SignInViewModel());
  }

  List<Widget> buidlUI(SignInViewModel auth) {
    return [headerSignIn(title: 'Email', isLoading: auth.isBusy)];
  }

  List<Widget> buildInput(SignInViewModel auth) {
    if (_formType == FormType.login) {
      return [
        textField(
          key: Key('email'),
          hintText: "Email",
          onSaved: (value) => _email = value,
          validator: (value) => value!.isEmpty ? "'Email can't be empty" : null,
          keyboardType: TextInputType.emailAddress,
          isLoading: auth.isBusy,
        ),
        textField(
            key: Key('password'),
            hintText: "Password",
            obscureText: kDebugMode ? false : _obscureText,
            isLoading: auth.isBusy,
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
          isLoading: auth.isBusy,
          validator: (value) =>
              value!.isEmpty ? "'Username can't be empty" : null,
        ),
        textField(
            key: Key('email'),
            hintText: "Email",
            isLoading: auth.isBusy,
            onSaved: (value) => _email = value,
            validator: (value) =>
                value!.isEmpty ? "'Email can't be empty" : null,
            keyboardType: TextInputType.emailAddress),
        textField(
            key: Key('password'),
            hintText: "Password",
            isLoading: auth.isBusy,
            obscureText: kDebugMode ? false : _obscureText,
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

  List<Widget> buildButton(SignInViewModel auth) {
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
              onPressed: auth.isBusy
                  ? null
                  : () {
                      saveAndSubmit(auth);
                    }),
        ),
        new FlatButton(
          child: Text(
            "Create new account",
            style: TextStyleHelper.kSubtitleStyle,
          ),
          onPressed: auth.isBusy ? null : moveToRegister,
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
            onPressed: auth.isBusy
                ? null
                : () {
                    saveAndSubmit(auth);
                  },
          ),
        ),
        new FlatButton(
          child: Text("Have an account, Login",
              style: TextStyleHelper.kSubtitleStyle),
          onPressed: auth.isBusy ? null : moveToLogin,
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

Widget headerSignIn({String? title, bool? isLoading}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
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
