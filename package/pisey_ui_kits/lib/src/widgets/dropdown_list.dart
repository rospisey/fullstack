part of pisey_ui_kits;

class MyDropDownFormField extends StatelessWidget {
  final List? categories;
  final String? valueSelected;

  const MyDropDownFormField({Key? key, this.categories, this.valueSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: myMargin(),
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: myBoxDecorationOutline(),
        child: DropdownButtonFormField(
            itemHeight: 50,
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(border: InputBorder.none),
            onChanged: (value) {},
            onSaved: (value) {},
            value: valueSelected,
            hint: Text('Select Category'),
            items: categories!.map((f) {
              return DropdownMenuItem(
                child: Text(f),
                value: f,
              );
            }).toList()));
  }
}

class MyDropDownButton extends StatelessWidget {
  final List? categories;
  final String? valueSelected;
  final void Function(Object?)? onChanged;

  const MyDropDownButton(
      {Key? key, this.categories, this.valueSelected, this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: myMargin(),
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: myBoxDecorationOutline(),
        child: DropdownButton(
            itemHeight: 50,
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
            onChanged: onChanged,
            value: valueSelected,
            hint: Text('Select Category'),
            items: categories!.map((f) {
              return DropdownMenuItem(
                child: Text(f),
                value: f,
              );
            }).toList()));
  }
}
