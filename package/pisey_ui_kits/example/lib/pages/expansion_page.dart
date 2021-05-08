import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  int id;
  String expandedValue;
  String headerValue;
  bool? isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      id: index,
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

// ...

List<Item> _data = generateItems(8);

class ExpansionPage extends StatefulWidget {
  @override
  _ExpansionPageState createState() => _ExpansionPageState();
}

class _ExpansionPageState extends State<ExpansionPage> {
  List<ExpansionPanelRadio> list = _data
      .map((e) => ExpansionPanelRadio(
          value: e.id,
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: Text(e.headerValue),
            );
          },
          body: MyListTileWithAvatar1(
            margin: myMargin(),
            assetImage: 'assets/404-not-found.png',
            boxDecoration: myBoxDecorationOutline(
              borderRadius: 8,
            ),
          )))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: myMargin(),
        child: MyExpansionPanelListRadio(list: list),
      ),
    );
  }
}
