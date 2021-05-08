import 'package:flutter/material.dart';

Future nextscreen(BuildContext context, Widget page) async {
  return await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

Future nextscreenNoBack(BuildContext context, Widget page) async {
  return await Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => page));
}

void backscreen(BuildContext context) {
  return Navigator.of(context).pop();
}
