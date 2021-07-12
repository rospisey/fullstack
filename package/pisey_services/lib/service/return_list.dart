part of pisey_services;

List<Widget> dataList<T>(
    {Widget Function(T)? builder,
    Iterable<T>? provider,
    bool Function(T)? where,
    bool hasWhere = true,
    bool shuffle = false}) {
  if (provider == null) {
    return [CircularProgressIndicator()];
  } else if (hasWhere) {
    if (provider.where(where!).toList().length == 0) {
      return [EmptyDataNoAppBar()];
    }
    return provider.where(where).map(builder!).toList();
  } else if (shuffle) {
    return provider.map(builder!).toList()..shuffle();
  }
  return provider.map(builder!).toList();
}

List<Widget> griddata<T>(
    {Widget Function(T)? builder,
    Iterable<T>? provider,
    bool Function(T)? where,
    bool hasWhere = true,
    bool shuffle = false}) {
  if (provider == null) {
    return [CircularProgressIndicator()];
  } else if (hasWhere) {
    if (provider.where(where!).toList().length == 0) {
      return [EmptyDataNoAppBar()];
    }
    return provider.where(where).map(builder!).toList();
  } else if (shuffle) {
    return provider.map(builder!).toList()..shuffle();
  }
  return provider.map(builder!).toList();
}

class EmptyDataNoAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SizedBox(
          //   height: 120,
          // ),
          Center(
            child: Text(
              'ពុំមានវីដេអូ',
              style: myDefaultTextStylePtSans(context),
            ),
          ),
        ],
      ),
    );
  }
}

// for (var item in myList) Text(item.title)

// Widget method1() {
//   return Column(
//     children: <Widget>[
//       Text('You can put other Widgets here'),
//       for (var item in items) Text(item),
//     ],
//   );
// }

// // map() + toList() + Spread Property
// Widget method2() {
//   return Column(
//     children: <Widget>[
//       Text('You can put other Widgets here'),
//       ...items.map((item) => Text(item)).toList(),
//     ],
//   );
// }

// // map() + toList()
// Widget method3() {
//   return Column(
//     // Text('You CANNOT put other Widgets here'),
//     children: items.map((item) => Text(item)).toList(),
//   );
// }
