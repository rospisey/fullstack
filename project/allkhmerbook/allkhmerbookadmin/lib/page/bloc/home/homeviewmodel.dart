import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:allkhmerbookadmin/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeviewModel extends BaseViewModel {
  final navigator = locator<NavigationService>();
  String _title = '';
  String get title => _title;
  void onChange(String value) {
    _title = value;
    notifyListeners();
  }

  void navigateToSecond() {
    navigator.navigateTo(Routes.secondView);
    notifyListeners();
  }
}
