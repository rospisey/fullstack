part of pisey_ui_kits;

///
/// #Todo
///
/// adding
/// int _currentIndex = 0;
///   final List<NavModel> model= [
///     NavModel(Text('Home'), HomePage(), Icon(EvaIcons.home,)),
///     NavModel(Text('Account'), AccountPage(), Icon(EvaIcons.personOutline))
///   ];

class MyNavBar extends StatelessWidget {
  final List<LocalModel>? pages;
  final List<DatabaseModel>? list;
  final int? currentIndex;
  final void Function(int)? onTap;
  final bool? showLabel;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Widget>? actions;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final Color? bottomColor;
  final IconThemeData? unselectedIconTheme;
  final IconThemeData? selectedIconTheme;
  final double? iconSize;

  final bool? showAppbar;
  final double? elevation;

  MyNavBar({
    Key? key,
    @required this.pages,
    @required this.currentIndex,
    @required this.onTap,
    this.showLabel,
    this.list,
    this.actions,
    this.drawer,
    this.appBar,
    this.bottomColor,
    this.unselectedIconTheme,
    this.selectedIconTheme,
    this.showAppbar: true,
    this.iconSize: 24.0,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: showAppbar == true
          ? appBar ??
              myAppbar(
                context,
                title: pages![currentIndex!].title,
              )
          : null,
      drawer: drawer ?? Drawer(),
      body: pages![currentIndex!].pages,
      bottomNavigationBar: BottomNavigationBar(
          elevation: elevation ?? 10,
          backgroundColor: bottomColor ?? MyColors.white,
          showSelectedLabels: showLabel ?? true,
          showUnselectedLabels: showLabel ?? true,
          unselectedIconTheme:
              unselectedIconTheme ?? IconThemeData(color: Colors.grey),
          selectedIconTheme:
              selectedIconTheme ?? IconThemeData(color: Colors.indigo),
          currentIndex: currentIndex!,
          onTap: onTap,
          items: pages!
              .map((e) =>
                  BottomNavigationBarItem(icon: e.icon!, title: Text(e.title!)))
              .toList()),
    );
  }
}



//Todo add package: scroll_bottom_navigation_bar: ^3.0.0

// class MyScrollNavBar extends StatelessWidget {
//   final List<LocalModel> pages;
//   final bool showLabel;
//   final ScrollController controller;
//   MyScrollNavBar(
//       {Key key,
//       @required this.pages,
//       this.showLabel,
//       @required this.controller})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: ScrollAppBar(
//         controller: controller,
//         title: Text(
//           "App Bar",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Snap(
//         controller: controller.bottomNavigationBar,
//         child: ValueListenableBuilder<int>(
//             valueListenable: controller.bottomNavigationBar.tabNotifier,
//             builder: (context, value, child) {
//               return pages[controller.bottomNavigationBar.tabNotifier.value]
//                   .pages;
//             }),
//       ),
//       bottomNavigationBar: ScrollBottomNavigationBar(
//           controller: controller,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           unselectedIconTheme: IconThemeData(color: Colors.grey),
//           selectedIconTheme: IconThemeData(color: Colors.black),
//           items: pages
//               .map((e) =>
//                   BottomNavigationBarItem(icon: e.icon, title: Text(e.title)))
//               .toList()),
//     );
//   }
// }
