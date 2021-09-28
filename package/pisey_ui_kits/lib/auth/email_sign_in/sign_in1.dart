part of pisey_ui_kits;

class SignInPage1 extends StatefulWidget {
  final GlobalKey<ScaffoldState>? snackbar;
  SignInPage1({
    Key? key,
    this.snackbar,
  }) : super(key: key);

  @override
  _SignInPage1State createState() => _SignInPage1State();
}

class _SignInPage1State extends State<SignInPage1> {
  bool offsecureText = true;
  Icon lockIcon = Icon(Icons.hide_image);
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  String? email;
  String? pass;

  void lockPressed() {
    if (offsecureText == true) {
      setState(() {
        offsecureText = false;
        lockIcon = Icon(Icons.hide_image);
      });
    } else {
      setState(() {
        offsecureText = true;
        lockIcon = Icon(Icons.show_chart_outlined);
      });
    }
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  // handleSignInwithemailPassword () async{
  //   // final InternetBloc ib = Provider.of<InternetBloc>(context );
  //   // final SignInBloc sb = Provider.of<SignInBloc>(context );
  //   // await ib.checkInternet();
  //   if (formKey.currentState.validate()){
  //     formKey.currentState.save();
  //     FocusScope.of(context).requestFocus(new FocusNode());

  //     await ib.checkInternet();
  //     if(ib.hasInternet == false){
  //         openSnacbar(_scaffoldKey, 'No internet connection!');
  //       }else{
  //         setState(() {
  //           signInStart = true;
  //         });
  //         sb.signInwithEmailPassword(email, pass).then((_)async{
  //           if(sb.hasError == false){

  //             sb.getUserData(sb.uid)
  //             .then((value) => sb.saveDataToSP()
  //             .then((value) => sb.setSignIn()
  //             .then((value){
  //               setState(() {
  //                 signInComplete = true;
  //               });
  //               sb.handleAfterSignup(context);
  //             })));
  //           } else{
  //             setState(() {
  //               signInStart = false;
  //             });
  //             openSnacbar(_scaffoldKey, sb.errorCode);
  //           }
  //         });

  //       }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey, backgroundColor: Colors.white, body: signInUI());
  }

  Future<void> saveAndSubmit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).requestFocus(new FocusNode());
      try {
        _toggleLoading();
        final provider = Provider.of<BaseAuth>(context, listen: false);
        // User user =
        await provider.signInWithEmailAndPassword(email!, pass!).then((value) {
          if (!provider.getCurrentUser().emailVerified) {
            nextscreen(context, CheckVerifyEmail());
          }
        });
        // await StorageManager.sharedPreferences.setString('uid', user.uid);
        // String uid = StorageManager.sharedPreferences.getString('uid');
        // print(uid);

      } catch (e) {
        _toggleLoading();
        print(e);
      }
    }
  }

  Widget signInUI() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            // Container(
            //   alignment: Alignment.centerLeft,
            //   width: double.infinity,
            //   child: IconButton(
            //     alignment: Alignment.centerLeft,
            //     padding: EdgeInsets.all(0),
            //     icon: Icon(Icons.keyboard_backspace),
            //     onPressed: (){
            //       Navigator.pop(context);
            //     }),
            // ),
            Text('Sign In',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.black)),
            Text('Follow the simple steps',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            SizedBox(
              height: 80,
            ),

            TextFormField(
              enabled: _isLoading ? false : true,
              decoration: InputDecoration(
                hintText: 'username@mail.com',
                //prefixIcon: Icon(Icons.email),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey),
                hintStyle: TextStyle(color: Colors.grey),
                counterStyle: TextStyle(color: Colors.grey),
              ),
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value!.length == 0) return "Email can't be empty";
                return null;
              },
              onChanged: (String value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),

            TextFormField(
              enabled: _isLoading ? false : true,
              obscureText: offsecureText,
              controller: passCtrl,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter Password',
                labelStyle: TextStyle(color: Colors.grey),
                hintStyle: TextStyle(color: Colors.grey),
                counterStyle: TextStyle(color: Colors.grey),
                suffixStyle: TextStyle(color: Colors.grey),
                //prefixIcon: Icon(Icons.vpn_key),
                suffixIcon: IconButton(
                  icon: lockIcon,
                  onPressed: () {
                    lockPressed();
                  },
                  color: Colors.grey,
                ),
              ),
              validator: (String? value) {
                if (value!.length == 0) return "Password can't be empty";
                return null;
              },
              onChanged: (String value) {
                setState(() {
                  pass = value;
                });
              },
            ),

            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  //nextScreen(context, ForgotPasswordPage());
                  // Navigator.push(context, CupertinoPageRoute(builder: (context) => ForgotPasswordPage()));
                },
              ),
            ),

            Container(
              height: 45,
              child: RaisedButton(
                  color: Colors.deepPurpleAccent,
                  disabledColor: Colors.deepPurpleAccent,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text(
                          'Sign In',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                  onPressed: _isLoading ? null : saveAndSubmit),
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account?"),
                FlatButton(
                    child: Text('Sign Up',
                        style: TextStyle(color: Colors.deepPurpleAccent)),
                    onPressed: () => nextscreen(context, SignUpPage1()))
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
