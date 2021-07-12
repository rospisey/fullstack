import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:allkhmerbookadmin/page/bloc/counter_test/counter_service.dart';
import 'package:stacked/stacked.dart';

class SingleViewModel extends ReactiveViewModel {
  final _counterService = locator<CounterService>();
  int get counter => _counterService.counter;
  void updateCounter() {
    _counterService.incrementCounter();
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_counterService];
}
