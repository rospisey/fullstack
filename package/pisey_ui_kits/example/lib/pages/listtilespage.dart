import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

class ListTilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyListView(
      list: [
        SizedBox(
          height: 10,
        ),
        MyListTileForIndicator(),
        SizedBox(
          height: 10,
        ),
        MyListTileIcon(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
