part of pisey_ui_kits;

class MyDropDownList extends StatelessWidget {
  final List? categories;
  final String? valueSelected;

  const MyDropDownList({Key? key, this.categories, this.valueSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(30)),
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
