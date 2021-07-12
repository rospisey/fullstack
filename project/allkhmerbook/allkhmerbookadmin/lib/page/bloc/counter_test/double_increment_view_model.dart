import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import 'counter_service.dart';

class DoubleIncrementViewModel extends ReactiveViewModel {
  final _counterService = locator<CounterService>();
  int get counter => _counterService.counter;
  void updateCounter() {
    _counterService.doubleCounter();
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_counterService];
}
