import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';
import 'pages/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: MyColors.white,
              iconTheme: IconThemeData(color: MyColors.black),
              textTheme: TextTheme(title: myDefaultTextStyle(context)))),
      home: HomePage(),
    );
  }
}
