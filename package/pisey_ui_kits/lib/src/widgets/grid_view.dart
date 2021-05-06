part of pisey_ui_kits;

class MyGridView extends StatelessWidget {
  final List<Widget>? children;
  final int? count;

  const MyGridView({Key? key, this.children, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: count!,
      childAspectRatio: 2.5,
      // children: List.generate(
      //   itemNames.length,
      //   (index) {
      //     return Stack(
      //       fit: StackFit.expand,
      //       children: <Widget>[
      //         Hero(
      //           tag: 'tile$index', //using a different hero widget tag for
      //           // each page mapped to the page's index value
      //           child: SexyTile(),
      //         ),
      //         Container(
      //           margin: EdgeInsets.all(15.0),
      //           child: Material(
      //             color: Colors.transparent,
      //             child: InkWell(
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: <Widget>[
      //                   Hero(
      //                     tag: 'title$index',
      //                     child: Material(
      //                       color: Colors.transparent,
      //                       child: Text(
      //                         '${itemNames[index]}',
      //                         style: MyDefaultTextStyle.primary,
      //                         softWrap: true,
      //                         overflow: TextOverflow.fade,
      //                         maxLines: 1,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               splashColor: MyColors.accent,
      //               borderRadius: BorderRadius.circular(15.0),
      //               onTap: () {},
      //             ),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // ),
      children: children!.map((index) {
        return index;
      }).toList(),
    );
  }
}
