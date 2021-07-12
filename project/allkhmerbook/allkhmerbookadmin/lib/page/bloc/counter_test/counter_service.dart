import 'package:stacked/stacked.dart';

class CounterService with ReactiveServiceMixin {
  ReactiveValue<int> _counter = ReactiveValue<int>(0);
  int get counter => _counter.value;
  CounterService() {
    listenToReactiveValues([_counter]);
  }

  void incrementCounter() {
    _counter.value++;
  }

  void doubleCounter() {
    _counter.value *= 2;
  }
}
