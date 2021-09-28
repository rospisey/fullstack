part of pisey_ui_kits;

class MyTabBar extends StatefulWidget {
  final List<MyModel>? pages;
  final void Function()? onPressed;

  const MyTabBar({Key? key, this.pages, this.onPressed}) : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.pages!.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'MathTeamKh',
            style: myDefaultTextStylePtSans(context),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: psColorBlackToWhite(context),
            ),
            onPressed: () {
              // _scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              color: psColorBlackToWhite(context),
            ),
            IconButton(
                icon: Icon(Icons.notification_add_outlined),
                onPressed: widget.onPressed,
                color: psColorBlackToWhite(context)),
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
                        style: myDefaultTextStylePtSans(context),
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
