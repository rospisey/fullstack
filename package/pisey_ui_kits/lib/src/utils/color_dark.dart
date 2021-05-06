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

bool isThemeCurrentlyDark(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true;
  } else {
    return false;
  }
} //returns current theme status

Color invertColorsTheme(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MyColors.primary;
  } else {
    return MyColors.accent;
  }
} //returns appropriate theme colors for ui elements

Color invertInvertColorsTheme(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MyColors.accent;
  } else {
    return MyColors.primary;
  }
} //keeps the same colors lol

Color inNormalIsDarkToLight(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MyColors.light;
  } else {
    return MyColors.dark;
  }
} //returns appropriate mild colors for text visibility

Color inNormalIsLightToDark(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MyColors.dark;
  } else {
    return MyColors.light;
  }
} //keeps the same colors lol

Color inNormalIsBlackToWhite(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MyColors.white;
  } else {
    return MyColors.black;
  }
} //returns appropriate strong colors for text visibility

Color inNormalIsWhiteToBlack(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MyColors.black;
  } else {
    return MyColors.white;
  }
} //keeps the same colors lol

Color inNormalIsYellowToOrange(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MaterialColors.orange;
  } else {
    return MaterialColors.yellow;
  }
} //returns appropriate material colors

Color inNormalIsOrangeToYellow(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MaterialColors.yellow;
  } else {
    return MaterialColors.orange;
  }
} //keeps the same colors lol

Color inNormalShadowIsLightToBlack(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
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
