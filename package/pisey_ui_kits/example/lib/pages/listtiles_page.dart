import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

class ListTilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyListView(
      list: [
        SizedBox(
          height: 5,
        ),
        MyListTileForIndicator(),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: myMargin(),
          child: MyListTileWithAvatar1(
            tag: 'abc',
            chipName: 'Politics',
            date: '02,June,2020',
            title: 'MyListTileWithAvatar1',
            assetImage: 'assets/404-not-found.png',
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: myMargin(),
          child: MyListTileWithAvatar2(
            date: 'date',
            love: '0',
            title: 'MyListTileWithAvatar2',
            assetImage: 'assets/404-not-found.png',
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: myMargin(),
          child: MyListTileWithAvatar3(
            assetImage: 'assets/404-not-found.png',
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: myMargin(),
          child: MyListTileWithAvatar4(
            assetImage: 'assets/404-not-found.png',
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: myMargin(),
          child: MyListTileWithAvatar5(
            assetImage: 'assets/404-not-found.png',
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: myMargin(),
          child: MyListTileWithAvatar6(
            assetImage: 'assets/404-not-found.png',
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
