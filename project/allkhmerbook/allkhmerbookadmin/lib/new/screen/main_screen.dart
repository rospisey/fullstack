import 'dart:html';

import 'package:allkhmerbookadmin/new/navigator/route_page_manager.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Main Router Screen'),
        ),
        body: Row(
          children: [
            Flexible(
              child: ListView(
                children: [ListTile()],
              ),
              flex: 1,
            ),
            Flexible(
              child: Text('data'),
              flex: 3,
            ),
          ],
        ));
  }
}
