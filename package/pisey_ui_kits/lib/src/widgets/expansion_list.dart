part of pisey_ui_kits;

class MyExpansionPanelListRadio extends StatefulWidget {
  final List<ExpansionPanelRadio>? list;

  const MyExpansionPanelListRadio({
    Key? key,
    @required this.list,
  }) : super(key: key);
  @override
  _MyExpansionPanelListRadioState createState() =>
      _MyExpansionPanelListRadioState();
}

class _MyExpansionPanelListRadioState extends State<MyExpansionPanelListRadio> {
  Widget _buildPanel() {
    return ExpansionPanelList.radio(
        elevation: 1,
        dividerColor: Colors.blue,
        children: widget.list!.map<ExpansionPanelRadio>((child) {
          return ExpansionPanelRadio(
              backgroundColor: child.backgroundColor,
              canTapOnHeader: child.canTapOnHeader,
              value: child.value,
              headerBuilder: child.headerBuilder,
              body: child.body);
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }
}
