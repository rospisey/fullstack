part of pisey_ui_kits;

EdgeInsets myMargin({
  double? left,
  double? right,
  double? bottom,
  double? top,
}) {
  return EdgeInsets.only(
      top: top ?? 5, bottom: bottom ?? 5, left: left ?? 15, right: right ?? 15);
}

DecorationImage myDecorationImage(
    {@required String? url, @required String? assetImage}) {
  if (url == null) {
    return DecorationImage(
        image: AssetImage(assetImage ?? ''), fit: BoxFit.cover);
  } else {
    return DecorationImage(image: NetworkImage(url), fit: BoxFit.cover);
  }
}

BoxDecoration myBoxDecorationShadow(
    {Color? color,
    double? borderRadius,
    Color? borderColor,
    List<BoxShadow>? boxShadow}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.circular(borderRadius ?? 12),
    border: Border.all(color: borderColor ?? Colors.transparent),
    boxShadow: boxShadow ??
        <BoxShadow>[
          BoxShadow(
              color: Colors.grey[300]!, blurRadius: 10, offset: Offset(3, 3))
        ],
  );
}

BoxDecoration myBoxDecorationOutline(
    {Color? color,
    double? borderRadius,
    Color? borderColor,
    List<BoxShadow>? boxShadow}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.circular(borderRadius ?? 10),
    border: Border.all(color: borderColor ?? Colors.grey[200]!),
    boxShadow: boxShadow ??
        <BoxShadow>[
          BoxShadow(
              color: Colors.transparent, blurRadius: 0, offset: Offset(0, 0))
        ],
  );
}

PreferredSizeWidget myAppbar(BuildContext? context,
    {@required String? title,
    Widget? text,
    Color? backgroundColor,
    List<Widget>? actions,
    double? elevation}) {
  return AppBar(
    elevation: elevation ?? 1,
    backgroundColor: backgroundColor ?? MyColors.white,
    title: text ??
        Text(
          title!,
          style: myDefaultTextStylePtSans(context!, color: Colors.indigo),
        ),
    leading: IconButton(
      icon: Icon(
        Icons.menu_rounded,
        color: Colors.indigo,
      ),
      onPressed: () {},
    ),
    actions: actions ??
        [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.indigo,
            ),
            onPressed: () {},
          ),
        ],
  );
}

PreferredSize myAppBarResponsive() {
  return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: Container(
        height: 60,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: myBoxDecorationOutline(borderRadius: 0),
        child: Row(
          children: <Widget>[
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.deepPurpleAccent,
                        fontFamily: 'Muli'),
                    text: "Homepage",
                    children: <TextSpan>[
                  TextSpan(
                      text: ' - Admin Panel',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                          fontFamily: 'Muli'))
                ])),
            Spacer(),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey[400]!,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ]),
              child: TextButton.icon(
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith((states) =>
                        EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15)),
                  ),
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  onPressed: () {} //handleLogOut(),
                  ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton.icon(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) =>
                      EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15)),
                ),
                icon: Icon(
                  Icons.person,
                  color: Colors.grey[800],
                  size: 20,
                ),
                label: Text(
                  'Signed as ${'ab.userType'}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.deepPurpleAccent,
                      fontSize: 16),
                ),
                onPressed: () => null,
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ));
}

TextStyle myDefaultTextStylePtSans(BuildContext context,
    {Color? color, double? fontSize}) {
  return GoogleFonts.ptSans(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.w600,
      color: color ?? psColorBlackToWhite(context));
}

TextStyle myDefaultTextStylekdamThmor(BuildContext context,
    {Color? color, double? fontSize}) {
  return GoogleFonts.kdamThmor(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.w600,
      color: color ?? psColorBlackToWhite(context));
}
