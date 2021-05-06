part of pisey_ui_kits;

class MyTabBar extends StatefulWidget {
  final List<MyModel>? pages;
  final void Function()? onPressed;

  const MyTabBar({Key? key, this.pages, this.onPressed}) : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  File? _image;

  Future<PickedFile> getImaageFile(ImageSource source) async {
    var image = await ImagePicker().getImage(
        source: source, imageQuality: 10, maxHeight: 512, maxWidth: 512);
    return image!;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.pages!.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'MathTeamKh',
            style: myDefaultTextStyle(context),
          ),
          leading: IconButton(
            icon: Icon(
              EvaIcons.menu,
              color: inNormalIsBlackToWhite(context),
            ),
            onPressed: () {
              // _scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(EvaIcons.search),
              onPressed: () {},
              color: inNormalIsBlackToWhite(context),
            ),
            IconButton(
                icon: Icon(EvaIcons.bellOutline),
                onPressed: widget.onPressed,
                color: inNormalIsBlackToWhite(context)),
          ],
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          elevation: 1,
          bottom: TabBar(
              // indicator: MD2Indicator(
              //     //it begins here
              //     indicatorHeight: 3,
              //     indicatorColor: Colors.deepPurpleAccent,
              //     indicatorSize: MD2IndicatorSize
              //         .normal //3 different modes tiny-normal-full
              //     ),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.deepPurpleAccent,
              unselectedLabelColor: Color(0xff5f6368), //niceish grey
              isScrollable: true,
              tabs: widget.pages!
                  .map(
                    (e) => Tab(
                      icon: e.icon,
                      child: Text(
                        e.text!,
                        style: myDefaultTextStyle(context),
                      ),
                    ),
                  )
                  .toList()),
        ),
        body: TabBarView(children: widget.pages!.map((e) => e.pages!).toList()),
      ),
    );
  }
}
