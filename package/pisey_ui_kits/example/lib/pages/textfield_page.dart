import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

class TextFieldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextFields(
          maxLines: 1,
        ),
        MyTextFields(
          maxLines: 3,
        ),
        MyTextFieldWithAvatar(
          url: MyTextString.url,
        )
      ],
    );
  }
}
