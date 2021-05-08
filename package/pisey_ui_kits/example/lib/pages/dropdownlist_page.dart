import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

final List categories = [
  'Politics',
  'Sports',
  'Science',
  'Technology',
  'Travel',
  'Entertainment',
];

class DropDownListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        MyDropDownFormField(
          categories: categories,
        ),
        SizedBox(
          height: 10,
        ),
        MyDropDownButton(
          categories: categories,
        )
      ],
    );
  }
}
