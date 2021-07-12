import 'package:stacked/stacked.dart';

class SecondviewModel extends BaseViewModel {
  String _title = '';
  String get title => _title;
  void onChange(String value) {
    _title = value;
    notifyListeners();
  }
}
