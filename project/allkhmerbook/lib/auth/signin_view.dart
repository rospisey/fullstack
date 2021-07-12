import 'package:allkhmerbook/auth/email_sign_in/signin_signup_page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'phone_sign_in/phone_signin_page.dart';

class SignInPageView extends StatefulWidget {
  @override
  _SignInPageViewState createState() => _SignInPageViewState();
}

class _SignInPageViewState extends State<SignInPageView> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final kTitleStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'khmerfont',
    fontSize: 26.0,
    height: 1,
  );

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  final kSubtitleStyle = TextStyle(
      color: Color(0xFFBEE5E8),
      fontSize: 22.0,
      height: 1.0,
      fontFamily: 'khmerfont');

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
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
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                    height: 600.0,
                    child: PageView(
                      // physics: NeverScrollableScrollPhysics(),
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,

                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        // SocailSignIn(
                        //   snackbar: _scaffoldKey,
                        // ),
                        PhoneAuth(),
                        SignInPage2(
                          snackbar: _scaffoldKey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
