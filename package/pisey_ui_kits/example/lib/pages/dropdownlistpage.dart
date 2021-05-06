import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

class DropDownListPage extends StatelessWidget {
  final List categories = [
    'Politics',
    'Sports',
    'Science',
    'Technology',
    'Travel',
    'Entertainment',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        MyDropDownList(
          categories: categories,
        )
      ],
    );
  }
}
