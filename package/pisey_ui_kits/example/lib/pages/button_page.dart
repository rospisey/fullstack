import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool enable = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 5,
        ),
        PsButtonOutlineWithIcon(onPressed: () {
          print('hello');
        }),
        SizedBox(
          height: 5,
        ),
        PsButtonSplash(
          splashColor: Colors.indigo.withOpacity(0.1),
          onTap: () {
            print('tap');
          },
          borderRadius: 12,
          child: MyListTileWithAvatar1(
            chipName: 'chpname',
            date: 'date',
            tag: 'tag',
            title: 'MyListTileWithAvatar1',
            assetImage: 'assets/404-not-found.png',
            boxDecoration: myBoxDecorationOutline(),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        PsButtonBouncing(
          upperBound: 0.02,
          borderRadius: 12,
          onTap: () {},
          child: MyListTileWithAvatar2(
            assetImage: 'assets/404-not-found.png',
          ),
        ),
        SizedBox(
          height: 5,
        ),
        PsButtonSplahBouncing(
            borderRadius: 12,
            child: MyListTileWithAvatar3(
              assetImage: 'assets/404-not-found.png',
            ),
            upperBound: 0.02,
            onTap: () {}),
      ],
    );
  }

  bool isLoading = false;
}
