part of pisey_ui_kits;

// class MyListTileWithTextUsedWithGridView extends StatefulWidget {
//   final void Function()? onTap;
//   final String? tag;
//   final String? text;
//   final Widget? child;
//   final EdgeInsetsGeometry? margin;
//   final double? height;

//   const MyListTileWithTextUsedWithGridView(
//       {Key? key,
//       this.onTap,
//       this.tag,
//       this.text,
//       this.child,
//       this.margin,
//       this.height})
//       : super(key: key);

//   @override
//   _MyListTileWithTextUsedWithGridViewState createState() =>
//       _MyListTileWithTextUsedWithGridViewState();
// }

// class _MyListTileWithTextUsedWithGridViewState
//     extends State<MyListTileWithTextUsedWithGridView> {
//   bool enable = false;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       // fit: StackFit.expand,
//       children: <Widget>[
//         // SexyTile(),
//         widget.child!,
//         Container(
//           margin: widget.margin,
//           child: Material(
//             color: enable ? Colors.black.withOpacity(0.1) : Colors.transparent,
//             borderRadius: BorderRadius.circular(12),
//             child: GestureDetector(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Material(
//                       color: Colors.transparent,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         height: widget.height,
//                         child: Text(''),
//                       ))
//                 ],
//               ),
//               // splashColor: MyColors.accent.withOpacity(0.4),

//               onPanDown: (details) {
//                 print('pan tap');
//                 setState(() {
//                   enable = true;
//                 });
//               },
//               onPanEnd: (details) {
//                 setState(() {
//                   enable = false;
//                 });
//               },
//               onPanCancel: () {
//                 setState(() {
//                   enable = false;
//                 });
//               },
//               onTapDown: (details) => print('tap down'),
//               onTap: () {
//                 setState(() {
//                   enable = false;
//                 });
//               },
//               // borderRadius: BorderRadius.circular(15.0),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class MyListTileForIndicator extends StatelessWidget {
  final double? height;
  final Widget? icon;
  final Widget? title;
  final Widget? numberIndicate;

  const MyListTileForIndicator(
      {Key? key, this.height, this.icon, this.title, this.numberIndicate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: height ?? 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey[200]!, blurRadius: 5, offset: Offset(5, 5))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 25, left: 20),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.orangeAccent[400]!,
                            blurRadius: 2,
                            offset: Offset(5, 5))
                      ]),
                  child: icon ?? Icon(EvaIcons.menu2Outline),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 25),
                  child: title ??
                      Text(
                        'Total Items',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                )
              ],
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                numberIndicate ??
                    Text('1200',
                        style: TextStyle(fontSize: 55, color: Colors.white))
                // newsData != null
                //     ? Text('${newsData.length}',
                //         style: TextStyle(fontSize: 55, color: Colors.white))
                //     : CircularProgressIndicator()
              ],
            ),
            SizedBox(
              width: 30,
            )
          ],
        ),
      ),
    );
  }
}

class MyListTileWithAvatar1 extends StatelessWidget {
  final String? tag;
  final String? title;
  final String? date;
  final String? url;
  final String? chipName;
  final String? assetImage;
  final DecorationImage? decorationImage;
  final BoxDecoration? boxDecoration;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const MyListTileWithAvatar1({
    Key? key,
    this.tag,
    this.title,
    this.url,
    this.chipName,
    this.date,
    this.assetImage,
    this.decorationImage,
    this.boxDecoration,
    this.height,
    this.margin,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 170,
        margin: margin ?? myMargin(bottom: 0, left: 0, right: 0, top: 0),
        padding: EdgeInsets.all(15),
        decoration: boxDecoration ?? myBoxDecorationShadow(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Hero(
                tag: tag ?? 'tag',
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey[200]!,
                          blurRadius: 1,
                          offset: Offset(1, 1))
                    ],
                    image: decorationImage ??
                        myDecorationImage(assetImage: assetImage, url: url),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title ?? 'MyListTileWithAvatar1',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 3, bottom: 3),
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black12),
                      child: Text(
                        chipName ?? 'chip',
                        style: TextStyle(fontSize: 13, color: Colors.grey[900]),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          color: Colors.grey,
                          size: 20,
                        ),
                        Text(date ?? 'date',
                            style:
                                TextStyle(color: Colors.black38, fontSize: 12)),
                        Spacer(),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.black12,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.grey[900],
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.black12,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: Colors.grey[900],
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class MyListTileWithAvatar2 extends StatelessWidget {
  final String? title;
  final String? date;
  final String? url;
  final String? love;
  final String? assetImage;
  final DecorationImage? decorationImage;
  final BoxDecoration? boxDecoration;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const MyListTileWithAvatar2(
      {Key? key,
      this.title,
      this.date,
      this.url,
      this.love,
      this.assetImage,
      this.decorationImage,
      this.boxDecoration,
      this.height,
      this.margin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        padding: EdgeInsets.all(15),
        decoration: boxDecoration ?? myBoxDecorationShadow(),
        margin: margin ?? myMargin(bottom: 0, left: 0, right: 0, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey[200]!,
                          blurRadius: 1,
                          offset: Offset(1, 1))
                    ],
                    image: decorationImage ??
                        myDecorationImage(assetImage: assetImage, url: url)),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title ?? 'MyListTileWithAvatar2',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          color: Colors.grey,
                          size: 18,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(date ?? '04 June 2020',
                            style:
                                TextStyle(color: Colors.black38, fontSize: 12)),
                        Spacer(),
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          size: 18,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(love ?? '10',
                            style:
                                TextStyle(color: Colors.black38, fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class MyListTileWithAvatar3 extends StatelessWidget {
  final String? title;
  final String? date;
  final String? url;
  final String? love;
  final String? chip;
  final String? tag;
  final String? assetImage;
  final DecorationImage? decorationImage;
  final BoxDecoration? boxDecoration;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const MyListTileWithAvatar3(
      {Key? key,
      this.title,
      this.date,
      this.url,
      this.love,
      this.chip,
      this.tag,
      this.assetImage,
      this.decorationImage,
      this.boxDecoration,
      this.height,
      this.margin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 175,
        padding: EdgeInsets.all(15),
        margin: margin ?? myMargin(bottom: 0, left: 0, right: 0, top: 0),
        decoration: boxDecoration ?? myBoxDecorationShadow(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title ?? 'MyListTileWithAvatar3',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[700]),
                        child: Text(
                          chip ?? 'chip',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Hero(
                    tag: tag ?? 'tag',
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey[200]!,
                                blurRadius: 1,
                                offset: Offset(1, 1))
                          ],
                          image: decorationImage ??
                              myDecorationImage(
                                  assetImage: assetImage, url: url),
                        )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  date ?? 'date',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                Spacer(),
                Icon(
                  Icons.favorite,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(love ?? '0',
                    style: TextStyle(color: Colors.black38, fontSize: 13)),
              ],
            )
          ],
        ));
  }
}

class MyListTileWithAvatar4 extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? date;
  final String? url;
  final String? love;
  final String? tag;
  final String? assetImage;
  final DecorationImage? decorationImage;
  final BoxDecoration? boxDecoration;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const MyListTileWithAvatar4(
      {Key? key,
      this.title,
      this.date,
      this.url,
      this.love,
      this.assetImage,
      this.decorationImage,
      this.boxDecoration,
      this.height,
      this.tag,
      this.subtitle,
      this.margin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 240,
        width: MediaQuery.of(context).size.width,
        margin: margin ?? myMargin(bottom: 0, left: 0, right: 0, top: 0),
        padding: EdgeInsets.all(15),
        decoration: boxDecoration ?? myBoxDecorationShadow(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 5,
                  child: Column(
                    children: <Widget>[
                      Text(
                        title ?? 'MyListTileWithAvatar4',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800]),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        subtitle ?? 'MyListTileWithAvatar4',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Hero(
                    tag: tag ?? 'tag',
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey[200]!,
                                blurRadius: 1,
                                offset: Offset(1, 1))
                          ],
                          image: decorationImage ??
                              myDecorationImage(
                                  url: url, assetImage: assetImage),
                        )),
                  ),
                )
              ],
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  date ?? '',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Spacer(),
                Icon(
                  Icons.favorite,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(love ?? '0',
                    style: TextStyle(color: Colors.black38, fontSize: 13)),
              ],
            )
          ],
        ));
  }
}

class MyListTileWithAvatar5 extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? date;
  final String? url;
  final String? love;
  final String? chip;
  final String? tag;
  final String? assetImage;
  final DecorationImage? decorationImage;
  final BoxDecoration? boxDecoration;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const MyListTileWithAvatar5(
      {Key? key,
      this.title,
      this.date,
      this.url,
      this.love,
      this.chip,
      this.tag,
      this.assetImage,
      this.decorationImage,
      this.boxDecoration,
      this.height,
      this.subtitle,
      this.margin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 365,
      width: MediaQuery.of(context).size.width,
      decoration: boxDecoration ?? myBoxDecorationShadow(),
      margin: margin ?? myMargin(bottom: 0, left: 0, right: 0, top: 0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: tag ?? 'tag',
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  image: decorationImage ??
                      myDecorationImage(url: url, assetImage: assetImage)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.deepPurpleAccent.withOpacity(0.7)),
                    child: Text(
                      chip ?? 'chip',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  child: Text(
                    title ?? "MyListTileWithAvatar5",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  subtitle ?? 'subtitle',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: Colors.grey,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      date ?? 'date',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Spacer(),
                    Icon(
                      Icons.favorite,
                      color: Colors.grey,
                      size: 20,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(love ?? '0',
                        style: TextStyle(color: Colors.black38, fontSize: 13)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// {@tool snippet}
///Default
///```dart
/// margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5)
/// height: 170,
/// borderRadius: BorderRadius.circular(12)
/// ```
/// {@end-tool}
class MyListTileWithAvatar6 extends StatelessWidget {
  final String? title;
  final String? date;
  final String? url;
  final String? love;
  final String? chip;
  final String? tag;
  final String? assetImage;
  final DecorationImage? decorationImage;
  final BoxDecoration? boxDecoration;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const MyListTileWithAvatar6(
      {Key? key,
      this.title,
      this.date,
      this.url,
      this.love,
      this.chip,
      this.tag,
      this.assetImage,
      this.decorationImage,
      this.boxDecoration,
      this.height,
      this.margin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 170,
        padding: EdgeInsets.all(15),
        margin: margin ?? myMargin(bottom: 0, left: 0, right: 0, top: 0),
        decoration: boxDecoration ?? myBoxDecorationShadow(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Hero(
                tag: tag ?? 'tag',
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey[200]!,
                            blurRadius: 1,
                            offset: Offset(1, 1))
                      ],
                      image: decorationImage ??
                          myDecorationImage(url: url, assetImage: assetImage)),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title ?? 'MyListTileWithAvatar6',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 3, bottom: 3),
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black12),
                      child: Text(
                        chip ?? 'chip',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          date ?? 'date',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                        Spacer(),
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(love ?? '0',
                            style:
                                TextStyle(color: Colors.black38, fontSize: 13)),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
