import 'dart:async';

import 'package:mvvm_practice/models/counter.dart';

class CounterViewModel {
  final Counter _counter = Counter();
  final StreamController<Counter> _streamController = StreamController();

  CounterViewModel() {
    _streamController.add(_counter);
  }

  Stream get stream => _streamController.stream;
  Counter get counter => _counter;

  void incrementCounter() {
    _counter.value++;
    _streamController.add(_counter);
  }
}