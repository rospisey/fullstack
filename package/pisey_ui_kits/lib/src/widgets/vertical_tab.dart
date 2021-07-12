part of pisey_ui_kits;

// class PsWebVerticalTab extends StatelessWidget {
//   final int? initialIndex;
//   final List<Tab>? tabs;
//   final List<Widget>? contents;

//   const PsWebVerticalTab(
//       {Key? key, this.initialIndex, this.tabs, this.contents})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // var deviceType = getDeviceType(MediaQuery.of(context).size);
//     return VerticalTabs(
//       indicatorSide: IndicatorSide.start,
//       onSelect: (index) {
//         print(index);
//       },
//       tabBackgroundColor: Colors.white,
//       backgroundColor: Colors.white,
//       tabsElevation: 0.5,
//       tabsShadowColor: Colors.grey[500],
//       tabsWidth: 200,
//       indicatorColor: Colors.deepPurpleAccent,
//       selectedTabBackgroundColor: Colors.deepPurpleAccent.withOpacity(0.1),
//       indicatorWidth: 5,
//       disabledChangePageFromContentView: true,
//       initialIndex: initialIndex,
//       changePageDuration: Duration(microseconds: 1),
//       tabs: tabs,
//       contents: contents,
//     );
//   }
// }

enum IndicatorSide { start, end }

/// A vertical tab widget for flutter
class VerticalTabs extends StatefulWidget {
  final Key? key;
  final int initialIndex;
  final double tabsWidth;
  final double indicatorWidth;
  final IndicatorSide? indicatorSide;
  final List<LocalModel>? tabs;
  final List<Widget>? contents;
  final ui.TextDirection direction;
  final Color indicatorColor;
  final bool disabledChangePageFromContentView;
  final Axis? contentScrollAxis;
  final Color selectedTabBackgroundColor;
  final Color tabBackgroundColor;
  final TextStyle selectedTabTextStyle;
  final TextStyle tabTextStyle;
  final Duration changePageDuration;
  final Curve changePageCurve;
  final Color tabsShadowColor;
  final double tabsElevation;
  final Function(int tabIndex)? onSelect;
  final Color? backgroundColor;
  final bool? isDrawer;
  final bool? isPage;
  final ScrollPhysics? pageScrollPhysics;
  final GlobalKey? drawerKey;
  final Color? hoverColor;
  final double? tabHeight;
  final bool? isCloseDrawer;
  final Color? selectedSvgColor;
  final Color? svgColor;
  final bool hasIndicator;

  VerticalTabs({
    this.key,
    @required this.tabs,
    @required this.contents,
    this.tabsWidth = 200,
    this.indicatorWidth = 3,
    this.indicatorSide,
    this.initialIndex = 0,
    this.direction = ui.TextDirection.ltr,
    this.indicatorColor = Colors.green,
    this.disabledChangePageFromContentView = false,
    this.contentScrollAxis = Axis.horizontal,
    this.selectedTabBackgroundColor = const Color(0x1100ff00),
    this.tabBackgroundColor = const Color(0xfff8f8f8),
    this.selectedTabTextStyle = const TextStyle(color: Colors.black),
    this.tabTextStyle = const TextStyle(color: Colors.black38),
    this.changePageCurve = Curves.easeInOut,
    this.changePageDuration = const Duration(milliseconds: 300),
    this.tabsShadowColor = Colors.black54,
    this.tabsElevation = 2.0,
    this.onSelect,
    this.backgroundColor = Colors.white,
    this.isDrawer = false,
    this.isPage = false,
    this.pageScrollPhysics,
    this.drawerKey,
    this.hoverColor,
    this.tabHeight,
    this.isCloseDrawer = false,
    this.selectedSvgColor,
    this.svgColor,
    this.hasIndicator = false,
  })  : assert(
            tabs != null && contents != null && tabs.length == contents.length),
        super(key: key);

  @override
  _VerticalTabsState createState() => _VerticalTabsState();
}

class _VerticalTabsState extends State<VerticalTabs>
    with TickerProviderStateMixin {
  int? _selectedIndex;
  bool? _changePageByTapView;

  PageController pageController = PageController();

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = AlwaysScrollableScrollPhysics();

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    for (int i = 0; i < widget.tabs!.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ));
    }
    _selectTab(widget.initialIndex);

    if (widget.disabledChangePageFromContentView == true)
      pageScrollPhysics = NeverScrollableScrollPhysics();

    super.initState();
    if (!widget.isPage!) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        pageController.jumpToPage(widget.initialIndex);
        // pageController.animateToPage(widget.initialIndex,
        //     duration: Duration(milliseconds: 1), curve: Curves.);
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    Border border = Border(
//        right: BorderSide(
//            width: 0.5, color: widget.dividerColor));
//    if (widget.direction == TextDirection.rtl) {
//      border = Border(
//          left: BorderSide(
//              width: 0.5, color: widget.dividerColor));
//    }
    return Scaffold(
      key: widget.drawerKey,
      drawer: (widget.isDrawer!) ? buildDrawer() : null,
      body: Directionality(
        textDirection: widget.direction,
        child: Container(
          color: widget.backgroundColor ?? Theme.of(context).canvasColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    if (!widget.isDrawer!) buildDrawer(),
                    if (!widget.isPage!)
                      Expanded(
                        child: PageView.builder(
                          scrollDirection:
                              widget.contentScrollAxis ?? Axis.vertical,
                          physics:
                              widget.pageScrollPhysics ?? pageScrollPhysics,
                          onPageChanged: (index) {
                            if (_changePageByTapView == false ||
                                _changePageByTapView == null) {
                              _selectTab(index);
                            }
                            if (_selectedIndex == index) {
                              _changePageByTapView = null;
                            }
                            setState(() {});
                          },
                          controller: pageController,

                          // the number of pages
                          itemCount: widget.contents!.length,

                          // building pages
                          itemBuilder: (BuildContext context, int index) {
                            return widget.contents![index];
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material buildDrawer() {
    return Material(
      child: Container(
        width: getValueForScreenType<double>(
          context: context,
          mobile: MediaQuery.of(context).size.width * 0.8,
          tablet: widget.tabsWidth + 60,
          desktop: widget.tabsWidth + 60,
        ),
        child: ListView.builder(
          itemCount: widget.tabs!.length,
          itemBuilder: (context, index) {
            LocalModel tab = widget.tabs![index];

            Alignment alignment = Alignment.centerLeft;
            if (widget.direction == ui.TextDirection.rtl) {
              alignment = Alignment.centerRight;
            }

            Widget child;
            if (tab.child != null) {
              child = tab.child!;
            } else {
              child = Container(
                  height: widget.tabHeight ?? 60,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      (tab.icon != null)
                          ? Row(
                              children: <Widget>[
                                tab.icon!,
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            )
                          : Container(),
                      if (tab.svg != null)
                        Row(
                          children: <Widget>[
                            SvgPicture.string(
                              tab.svg!,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                              color: _selectedIndex == index
                                  ? (widget.selectedSvgColor ??
                                      psColorBlackToWhite(context))
                                  : (widget.svgColor ??
                                      psColorBlackToWhite(context)),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      (tab.title != null)
                          ? Container(
                              width: widget.tabsWidth,
                              child: Text(
                                tab.title!,
                                softWrap: true,
                                style: _selectedIndex == index
                                    ? widget.selectedTabTextStyle
                                    : widget.tabTextStyle,
                              ))
                          : Container(),
                    ],
                  ));
            }

            Color itemBGColor = widget.tabBackgroundColor;
            if (_selectedIndex == index)
              itemBGColor = widget.selectedTabBackgroundColor;

            // double left, right;
            // if (widget.direction == ui.TextDirection.rtl) {
            //   left = ((widget.indicatorSide == IndicatorSide.end)
            //       ? 0
            //       : null)!;
            //   right =
            //       ((widget.indicatorSide! == IndicatorSide.start)
            //           ? 0
            //           : null)!;
            // } else {
            //   left =
            //       ((widget.indicatorSide == IndicatorSide.start)
            //           ? 0
            //           : null)!;
            //   right = ((widget.indicatorSide == IndicatorSide.end)
            //       ? 0
            //       : null)!;
            // }

            return Stack(
              children: <Widget>[
                // if (!widget.isPage!)
                // Positioned(
                //   top: 2,
                //   bottom: 2,
                //   left: 5,
                //   width: widget.indicatorWidth,
                //   child: ScaleTransition(
                //     child: Container(
                //       color: widget.indicatorColor,
                //     ),
                //     scale: Tween(begin: 0.0, end: 1.0).animate(
                //       new CurvedAnimation(
                //         parent: animationControllers[index],
                //         curve: Curves.elasticOut,
                //       ),
                //     ),
                //   ),
                // ),

                PsButtonSplash(
                  selectedWidget: () =>
                      widget.hasIndicator ? _selectedIndex == index : false,
                  hoverColor: widget.hoverColor,
                  splashColor: Colors.indigo.withOpacity(0.1),
                  margin: myMargin(left: 0, bottom: 0, right: 0, top: 0),
                  onTap: () {
                    _changePageByTapView = true;
                    setState(() {
                      _selectTab(index);
                    });
                    if (widget.isPage!) {
                      // nextscreen(
                      //     context, widget.contents![index]);
                    }
                    if (!widget.isPage! || widget.isDrawer!) {
                      pageController.animateToPage(index,
                          duration: widget.changePageDuration,
                          curve: widget.changePageCurve);
                      // pageController.jumpToPage(index);
                    }
                    if (checkDeviceType(context) == DeviceScreenType.mobile &&
                        widget.isCloseDrawer!) Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            !widget.isPage! ? itemBGColor : Colors.transparent),
                    alignment: alignment,
                    padding: EdgeInsets.all(5),
                    child: child,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      elevation: widget.tabsElevation,
      shadowColor: widget.tabsShadowColor,
      shape: BeveledRectangleBorder(),
    );
  }

  void _selectTab(index) {
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    animationControllers[index].forward();

    if (widget.onSelect != null) {
      widget.onSelect!(_selectedIndex!);
    }
  }
}
