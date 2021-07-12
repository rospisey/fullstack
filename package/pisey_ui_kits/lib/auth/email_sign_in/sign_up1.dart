part of pisey_ui_kits;

class SignUpPage1 extends StatefulWidget {
  SignUpPage1({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpPage1State createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
  bool offsecureText = true;
  Icon lockIcon = Icon(EvaIcons.eyeOff);
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  String? email;
  String? pass;
  String? name;
  bool signUpStarted = false;
  bool signUpCompleted = false;

  void lockPressed() {
    if (offsecureText == true) {
      setState(() {
        offsecureText = false;
        lockIcon = Icon(EvaIcons.eyeOff);
      });
    } else {
      setState(() {
        offsecureText = true;
        lockIcon = Icon(EvaIcons.eye);
      });
    }
  }

  Future<void> saveAndSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        final provider = Provider.of<BaseAuth>(context, listen: false);
        // User user =
        await provider.createAccountWithEmailAndPassword(email!, pass!);
        if (!provider.getCurrentUser().emailVerified) {
          await provider.getCurrentUser().sendEmailVerification();
          backscreen(context);
        }

        // .then((value) => backscreen(context));

        // await StorageManager.sharedPreferences.setString('uid', user.uid);
        // String uid = StorageManager.sharedPreferences.getString('uid');
        // print(uid);
      } catch (e) {
        print('Error signin: $e');
      }
    }
  }

  // Future handleSignUpwithEmailPassword () async{
  //   final InternetBloc ib = Provider.of<InternetBloc>(context );
  //   final SignInBloc sb = Provider.of<SignInBloc>(context );
  //   await ib.checkInternet();
  //   if (formKey.currentState.validate()){
  //     formKey.currentState.save();
  //     FocusScope.of(context).requestFocus(new FocusNode());
  //     await ib.checkInternet();
  //     if(ib.hasInternet == false){
  //         openSnacbar(_scaffoldKey, 'No internet connection!');
  //       }else{
  //         setState(() {
  //           signUpStarted = true;
  //         });
  //         sb.signUpwithEmailPassword(name, email, pass).then((_)async{
  //           if(sb.hasError == false){
  //             sb.getTimestamp()
  //           .then((value) => sb.saveDataToSP()
  //           .then((value) => sb.saveToFirebase()
  //           .then((value) => sb.setSignIn()
  //           .then((value){
  //             setState(() {
  //               signUpCompleted = true;
  //             });
  //             sb.handleAfterSignup(context);
  //           }))));
  //           } else{
  //             setState(() {
  //               signUpStarted = false;
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
        key: _scaffoldKey, backgroundColor: Colors.white, body: signUpUI());
  }

  Widget signUpUI() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: IconButton(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.keyboard_backspace),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Text('Sign Up',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
            Text('Follow the simple steps',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            SizedBox(
              height: 60,
            ),
            TextFormField(
              controller: nameCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter Name',
                //prefixIcon: Icon(Icons.person)
              ),
              validator: (String? value) {
                if (value!.length == 0) return "Name can't be empty";
                return null;
              },
              onChanged: (String value) {
                setState(() {
                  name = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'username@mail.com',
                labelText: 'Email Address',
                //prefixIcon: Icon(Icons.email)
              ),
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
              controller: passCtrl,
              obscureText: offsecureText,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter Password',
                //prefixIcon: Icon(Icons.vpn_key),
                suffixIcon: IconButton(
                    icon: lockIcon,
                    onPressed: () {
                      lockPressed();
                    }),
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
              height: 45,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.deepPurpleAccent,
                  child: signUpStarted == false
                      ? Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      : signUpCompleted == false
                          ? CircularProgressIndicator()
                          : Text('Sign Up Successful!',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                  onPressed: () {
                    //  handleSignUpwithEmailPassword();
                    saveAndSubmit();
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Already have an account?'),
                FlatButton(
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.deepPurpleAccent),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SignInPage1()));
                    })
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
