part of pisey_ui_kits;

Future nextscreen(BuildContext context, Widget page) async {
  return await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}
