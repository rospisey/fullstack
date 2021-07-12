part of pisey_ui_kits;

class MyTextWidgetWithLine extends StatelessWidget {
  final String text;
  final Color? lineColor;

  const MyTextWidgetWithLine(
    this.text, {
    Key? key,
    this.lineColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
      child: Row(
        children: [
          Container(
            height: 25,
            width: 4,
            decoration: BoxDecoration(
                color: lineColor ?? Colors.indigo,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: myDefaultTextStylePtSans(context),
          ),
        ],
      ),
    );
  }
}

class MyTextWidgetWithIcon extends StatelessWidget {
  final String text;

  const MyTextWidgetWithIcon(
    this.text, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          SizedBox(
            width: 25,
          ),
          CircleAvatar(
            child: Icon(Icons.ac_unit),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: myDefaultTextStylePtSans(context),
          ),
        ],
      ),
    );
  }
}
