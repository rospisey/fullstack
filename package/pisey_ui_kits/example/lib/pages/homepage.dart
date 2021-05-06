import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

import 'buttonpage.dart';
import 'dropdownlistpage.dart';
import 'listtilespage.dart';
import 'pageviewpage.dart';
import 'textfieldpage.dart';

class HomePage extends StatelessWidget {
  final List<MyModel> itemNames = [
    MyModel(text: 'List Tiles', pages: ListTilesPage()),
    MyModel(text: 'Text Fields', pages: TextFieldPage()),
    MyModel(text: 'Button', pages: ButtonPage()),
    MyModel(text: 'Dropdown List', pages: DropDownListPage()),
    MyModel(text: 'Page View', pages: PageViewPage()),
  ];

  // final List<String> itemNames = [
  //   'Material++',
  //   'Gradient Cards',
  //   'About',
  // ];

  @override
  Widget build(BuildContext context) {
    return MyTabBar(
      pages: itemNames,
    );
  }
}
