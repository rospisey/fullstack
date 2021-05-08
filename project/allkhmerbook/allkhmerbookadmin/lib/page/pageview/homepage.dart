import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar('admin'),
      body: Container(),
    );
  }

  Widget _appBar(ab) {
    return PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          height: 60,
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey[300], blurRadius: 10, offset: Offset(0, 5))
          ]),
          child: Row(
            children: <Widget>[
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.deepPurpleAccent,
                          fontFamily: 'Muli'),
                      text: "Homepage",
                      children: <TextSpan>[
                    TextSpan(
                        text: ' - Admin Panel',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                            fontFamily: 'Muli'))
                  ])),
              Spacer(),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 10,
                          offset: Offset(2, 2))
                    ]),
                child: TextButton.icon(
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith((states) =>
                          EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 15)),
                    ),
                    icon: Icon(
                      LineIcons.sign,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      'Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    onPressed: () {} //handleLogOut(),
                    ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith((states) =>
                        EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15)),
                  ),
                  icon: Icon(
                    LineIcons.user,
                    color: Colors.grey[800],
                    size: 20,
                  ),
                  label: Text(
                    'Signed as ${'ab.userType'}',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.deepPurpleAccent,
                        fontSize: 16),
                  ),
                  onPressed: () => null,
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ));
  }
}
