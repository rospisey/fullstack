import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

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
          height: 10,
        ),
        BouncingButton(
          child: MyFlatButtonWithIcon(
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SplashButton(
          child: MyListTileWithTextUsedWithGridView(
            child: MyListTileWithAvatar6(),
            text: MyTextString.title,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            height: 170,
            onTap: () {
              print('hello');
            },
          ),
        ),
        SizedBox(
          height: 40,
        ),
        SplashAndBounceButton(
          child: MyListTileWithTextUsedWithGridView(
            child: MyListTileWithAvatar6(),
            text: MyTextString.title,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            height: 170,
            onTap: () {
              print('hello');
            },
          ),
        ),
        SizedBox(
          height: 40,
        ),
        BouncingButton(
          child: MyListTileWithTextUsedWithGridView(
            child: MyListTileWithAvatar6(),
            text: MyTextString.title,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            height: 170,
            onTap: () {
              print('hello');
            },
          ),
        ),
        SizedBox(
          height: 40,
        ),
        BouncingButton(
          child: Container(
            margin: EdgeInsets.all(15),
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 10,
                      offset: Offset(3, 3))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(EvaIcons.activity),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'លីមីត',
                  style: myDefaultTextStyle(context),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        MyTextUse('MyListTileWithAvatar6'),
        MyListTileWithTextUsedWithGridView(
          child: MyListTileWithAvatar6(),
          text: MyTextString.title,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          height: 170,
          onTap: () {
            print('hello');
          },
        ),
        MyTextUse('MyListTileWithAvatar5'),
        MyListTileWithTextUsedWithGridView(
          child: MyListTileWithAvatar5(),
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          text: MyTextString.title,
          height: 365,
          onTap: () {
            print('hello');
          },
        ),
        MyTextUse('MyListTileWithAvatar4'),
        MyListTileWithTextUsedWithGridView(
          child: MyListTileWithAvatar4(),
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          text: MyTextString.title,
          height: 240,
          onTap: () {
            print('hello');
          },
        ),
        MyTextUse('MyListTileWithAvatar3'),
        MyListTileWithTextUsedWithGridView(
          child: MyListTileWithAvatar3(),
          margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          text: MyTextString.title,
          height: 175,
          onTap: () {
            print('hello');
          },
        ),
        MyTextUse('MyListTileWithAvatar2'),
        MyListTileWithTextUsedWithGridView(
          child: MyListTileWithAvatar2(
            title: MyTextString.title,
          ),
          margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          text: MyTextString.title,
          height: 140,
          onTap: () {
            print('hello');
          },
        ),
        MyTextUse('MyListTileWithAvatar1'),
        MyListTileWithTextUsedWithGridView(
          child: MyListTileWithAvatar1(
            tag: 'abc',
            chip: 'Politics',
            date: '02,June,2020',
            title: MyTextString.title,
            url: MyTextString.url,
          ),
          margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          text: MyTextString.title,
          height: 180,
          onTap: () {
            print('hello');
          },
        ),
      ],
    );
  }
}
