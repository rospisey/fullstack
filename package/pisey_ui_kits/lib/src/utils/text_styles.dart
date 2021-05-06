part of pisey_ui_kits;

TextStyle myDefaultTextStyle(BuildContext context) {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: inNormalIsBlackToWhite(context));
}

class MyTextUse extends StatelessWidget {
  final String text;

  const MyTextUse(
    this.text, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 20, bottom: 10),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 4,
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
                color: inNormalIsBlackToWhite(context),
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.dangrek),
          ),
        ],
      ),
    );
  }
}
