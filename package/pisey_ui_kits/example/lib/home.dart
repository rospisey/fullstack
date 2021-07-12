import 'package:example/pages/expansion_page.dart';
import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

import 'pages/button_page.dart';
import 'pages/dropdownlist_page.dart';
import 'pages/listtiles_page.dart';
import 'pages/pageview_page.dart';
import 'pages/textfield_page.dart';

final List<MyModel> itemNames = [
  MyModel(text: 'List Tiles', pages: ListTilesPage()),
  MyModel(text: 'Button', pages: ButtonPage()),
  MyModel(text: 'Expansion', pages: ExpansionPage()),
  MyModel(text: 'Text Fields', pages: TextFieldPage()),
  MyModel(text: 'Dropdown List', pages: DropDownListPage()),
  MyModel(text: 'Page View', pages: PageViewPage()),
];

class HomePage extends StatelessWidget {
  // final List<String> itemNames = [
  //   'Material++',
  //   'Gradient Cards',
  //   'About',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBarResponsive(),
    );
  }
}
