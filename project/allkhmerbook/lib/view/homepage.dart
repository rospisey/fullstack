import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: myAppbar(context, title: 'Book Khmer'),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
              margin: myMargin(top: 10, bottom: 10, left: 0, right: 0),
              decoration: myBoxDecorationOutline(borderRadius: 0),
              child: Column(children: [
                MyTextWidgetWithLine('Catery'),
                ...localList
                    .take(index)
                    .map((e) => PsButtonSplash(
                        selectedWidget: () {
                          return false;
                        },
                        margin: myMargin(top: 0, bottom: 0, left: 0, right: 0),
                        onTap: () {},
                        child: MyTextWidgetWithIcon('text')))
                    .toList()
              ])),
          PsButtonSplash(
              selectedWidget: () {
                return false;
              },
              child: SizedBox(height: 20, child: Text('Show less')),
              onTap: () {
                if (index == 2) {
                  setState(() {
                    index = 5;
                  });
                } else if (index == 5) {
                  setState(() {
                    index = 2;
                  });
                }
              }),
        ],
      ),
    );
  }
}
