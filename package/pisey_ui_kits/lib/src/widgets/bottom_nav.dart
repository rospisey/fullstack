part of pisey_ui_kits;

//Todo
//adding
// int _currentIndex = 0;
//   final List<NavModel> model= [
//     NavModel(Text('Home'), HomePage(), Icon(EvaIcons.home,)),
//     NavModel(Text('Account'), AccountPage(), Icon(EvaIcons.personOutline))
//   ];

class MyNavBar extends StatelessWidget {
  final List<MyModel>? pages;
  final int? currentIndex;
  final void Function(int)? onTap;
  final bool? showLabel;

  MyNavBar(
      {Key? key,
      @required this.pages,
      @required this.currentIndex,
      @required this.onTap,
      this.showLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages![currentIndex!].pages,
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: showLabel,
          showUnselectedLabels: showLabel,
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedIconTheme:
              IconThemeData(color: inNormalIsBlackToWhite(context)),
          currentIndex: currentIndex!,
          onTap: onTap,
          items: pages!
              .map((e) =>
                  BottomNavigationBarItem(icon: e.icon!, title: Text(e.text!)))
              .toList()),
    );
  }
}

//Todo add package: scroll_bottom_navigation_bar: ^3.0.0

// class MyScrollNavBar extends StatelessWidget {
//   final List<MyModel>? pages;
//   final bool? showLabel;
//   final ScrollController? controller;
//   MyScrollNavBar(
//       {Key? key,
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
//         controller: controller!.bottomNavigationBar,
//         child: ValueListenableBuilder<int>(
//             valueListenable: controller!.bottomNavigationBar.tabNotifier,
//             builder: (context, value, child) {
//               return pages![controller!.bottomNavigationBar.tabNotifier.value]
//                   .pages!;
//             }),
//       ),
//       bottomNavigationBar: ScrollBottomNavigationBar(
//           controller: controller,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           unselectedIconTheme: IconThemeData(color: Colors.grey),
//           selectedIconTheme: IconThemeData(color: Colors.black),
//           items: pages!
//               .map((e) =>
//                   BottomNavigationBarItem(icon: e.icon!, title: Text(e.text!)))
//               .toList()),
//     );
//   }
// }
