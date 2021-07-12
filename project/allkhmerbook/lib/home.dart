import 'package:allkhmerbook/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MyNavBar(
      showLabel: false,
      showAppbar: false,
      pages: <LocalModel>[
        LocalModel(
            title: 'Home',
            icon: Icon(
              Icons.home,
            ),
            pages: Homepage()),
        LocalModel(
          title: 'Download',
          pages: Text('Hello'),
          icon: Icon(Icons.download_rounded),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
