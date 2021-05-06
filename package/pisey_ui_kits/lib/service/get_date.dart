part of pisey_ui_kits;

Future<String> getDate() async {
  DateTime now = DateTime.now();
  String _date = DateFormat('dd MMMM yy').format(now);
  String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
  return _date + _timestamp;
}
