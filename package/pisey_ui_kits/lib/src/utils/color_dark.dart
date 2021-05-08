part of pisey_ui_kits;

void doNothing() {
  print('Nothing is happening here (yet)');
} //better than doing null-ing, right? ;)

bool isIOS(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return true;
  } else {
    return false;
  }
} // check if android or ios

bool psIsThemeCurrentlyDark(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true;
  } else {
    return false;
  }
} //returns current theme status

Color invertColorsTheme(BuildContext context) {
  if (psIsThemeCurrentlyDark(context)) {
    return MyColors.primary;
  } else {
    return MyColors.accent;
  }
} //returns appropriate theme colors for ui elements

Color invertInvertColorsTheme(BuildContext context) {
  if (psIsThemeCurrentlyDark(context)) {
    return MyColors.accent;
  } else {
    return MyColors.primary;
  }
} //keeps the same colors lol

Color psColorDarkToLight(BuildContext context) {
  if (psIsThemeCurrentlyDark(context)) {
    return MyColors.light;
  } else {
    return MyColors.dark;
  }
} //returns appropriate mild colors for text visibility

Color psColorLightToDark(BuildContext context) {
  if (psIsThemeCurrentlyDark(context)) {
    return MyColors.dark;
  } else {
    return MyColors.light;
  }
} //keeps the same colors lol

Color psColorBlackToWhite(BuildContext context) {
  if (psIsThemeCurrentlyDark(context)) {
    return MyColors.white;
  } else {
    return MyColors.black;
  }
} //returns appropriate strong colors for text visibility

Color psColorWhiteToBlack(BuildContext context) {
  if (psIsThemeCurrentlyDark(context)) {
    return MyColors.black;
  } else {
    return MyColors.white;
  }
} //keeps the same colors lol

Color psYellowToOrange(BuildContext context) {
  if (psIsThemeCurrentlyDark(context)) {
    return MaterialColors.orange;
  } else {
    return MaterialColors.yellow;
  }
} //returns appropriate material colors

Color psColorOrangeToYellow(BuildContext context) {
  if (psIsThemeCurrentlyDark(context)) {
    return MaterialColors.yellow;
  } else {
    return MaterialColors.orange;
  }
} //keeps the same colors lol

Color psColorShadowIsLightToBlack(BuildContext context) {
  if (psIsThemeCurrentlyDark(context)) {
    return ShadowColors.dark;
  } else {
    return ShadowColors.light;
  }
} //returns appropriate colors for raised element shadows

// launchURL(String url) async {
//   if (await canLaunch(url)) {
//     print('Launching $url...');
//     await launch(url);
//   } else {
//     print('Error launching $url!');
//   }
// } //opens a custom url in the system browser
