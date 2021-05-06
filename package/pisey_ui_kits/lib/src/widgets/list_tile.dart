part of pisey_ui_kits;

class SexyTile extends StatelessWidget {
  const SexyTile({
    this.child,
    this.color,
    this.splashColor,
    this.onTap,
  });
  final Widget? child;
  final Color? color;
  final Color? splashColor;
  final Function()? onTap;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Material(
        color: color,
        elevation: 10.0,
        borderRadius: BorderRadius.circular(15.0),
        shadowColor: inNormalShadowIsLightToBlack(context),
        child: InkWell(
          child: child,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(15.0),
          // onTap: onTap == null ? doNothing : () => onTap(),
        ),
      ),
    );
  }
}

class MyListTileWithTextUsedWithGridView extends StatefulWidget {
  final void Function()? onTap;
  final String? tag;
  final String? text;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final double? height;

  const MyListTileWithTextUsedWithGridView(
      {Key? key,
      this.onTap,
      this.tag,
      this.text,
      this.child,
      this.margin,
      this.height})
      : super(key: key);

  @override
  _MyListTileWithTextUsedWithGridViewState createState() =>
      _MyListTileWithTextUsedWithGridViewState();
}

class _MyListTileWithTextUsedWithGridViewState
    extends State<MyListTileWithTextUsedWithGridView> {
  bool enable = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      children: <Widget>[
        // SexyTile(),
        widget.child!,
        Container(
          margin: widget.margin,
          child: Material(
            color: enable ? Colors.black.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Material(
                      color: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: widget.height,
                        child: Text(''),
                      ))
                ],
              ),
              // splashColor: MyColors.accent.withOpacity(0.4),

              onPanDown: (details) {
                print('pan tap');
                setState(() {
                  enable = true;
                });
              },
              onPanEnd: (details) {
                setState(() {
                  enable = false;
                });
              },
              onPanCancel: () {
                setState(() {
                  enable = false;
                });
              },
              onTapDown: (details) => print('tap down'),
              onTap: () {
                setState(() {
                  enable = false;
                });
              },
              // borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ],
    );
  }
}

class MyListTileWithAvatar1 extends StatelessWidget {
  final String? tag;
  final String? title;
  final String? date;
  final String? url;
  final String? chip;
  final void Function()? onTap;

  const MyListTileWithAvatar1(
      {Key? key,
      this.tag,
      this.title,
      this.url,
      this.chip,
      this.date,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      child: Container(
          margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
          height: 180,
          padding: EdgeInsets.all(15),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Hero(
                  tag: tag!,
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
                        image: DecorationImage(
                            image: NetworkImage(url!), fit: BoxFit.cover)),
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
                        title!,
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
                          chip!,
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[900]),
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
                          Text(date!,
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 12)),
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
          )),
      onTap: onTap,
    );
  }
}

class MyListTileForIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 150,
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
                  child: Icon(EvaIcons.menu2Outline),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 25),
                  child: Text(
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

class MyListTileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(
            left: 15,
          ),
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.message, color: Colors.white, size: 25),
          ),
          title: Text(
            'title',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey[900]),
          ),
          subtitle: Text('Sub Title',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45)),
          onTap: () {},
        ),
        Divider(
          color: Colors.black12,
          height: 2,
        )
      ],
    );
  }
}

class MyListTileWithAvatar2 extends StatelessWidget {
  final String? title;

  const MyListTileWithAvatar2({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      child: Container(
          margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
          height: 140,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 15,
                  offset: Offset(2, 2))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Hero(
                  tag: 'notification',
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
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://www.interconrooster.com/wp-content/uploads/2018/06/chunnat_biopng.png'),
                            fit: BoxFit.cover)),
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
                        title!,
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
                          Text('04 June 2020',
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 12)),
                          Spacer(),
                          Icon(
                            Icons.favorite,
                            color: Colors.grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text('10',
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
      onTap: () async {},
    );
  }
}

class MyListTileWithAvatar3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      child: Container(
          margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
          height: 175,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 10,
                    offset: Offset(3, 3))
              ]),
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
                          MyTextString.title,
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
                            'Politics',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Hero(
                      tag: 'popular',
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
                            image: DecorationImage(
                                image: NetworkImage(MyTextString.url),
                                fit: BoxFit.cover)),
                      ),
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
                    '02 June 2020',
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
                  Text('10',
                      style: TextStyle(color: Colors.black38, fontSize: 13)),
                ],
              )
            ],
          )),
      onTap: () {},
    );
  }
}

class MyListTileWithAvatar4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      child: Container(
          height: 240,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 10,
                    offset: Offset(3, 3))
              ]),
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
                          MyTextString.title,
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
                          MyTextString.subtitle,
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
                      tag: 'tab',
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
                            image: DecorationImage(
                                image: NetworkImage(MyTextString.url),
                                fit: BoxFit.cover)),
                      ),
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
                    '02 June 2020',
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
                  Text('10',
                      style: TextStyle(color: Colors.black38, fontSize: 13)),
                ],
              )
            ],
          )),
      onTap: () {},
    );
  }
}

class MyListTileWithAvatar5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      child: Container(
        height: 365,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 10,
                  offset: Offset(3, 3))
            ]),
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'tab2',
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    image: DecorationImage(
                        image: NetworkImage(MyTextString.url),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 6, bottom: 6),
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurpleAccent.withOpacity(0.7)),
                      child: Text(
                        'Politics',
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
                      MyTextString.title,
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
                    MyTextString.subtitle,
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
                        '02 June 2020',
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
                      Text('10',
                          style:
                              TextStyle(color: Colors.black38, fontSize: 13)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}

class MyListTileWithAvatar6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      child: Container(
          margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
          height: 170,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey[400]!,
                    blurRadius: 6,
                    offset: Offset(3, 3))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Hero(
                  tag: 'bookmarkindex',
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
                        image: DecorationImage(
                            image: NetworkImage(MyTextString.url),
                            fit: BoxFit.cover)),
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
                        MyTextString.title,
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
                          'Politics',
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
                            '04 June 2020',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 13),
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
                          Text('10',
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 13)),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
      onTap: () {},
    );
  }
}
