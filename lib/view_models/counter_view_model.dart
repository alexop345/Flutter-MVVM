import 'dart:async';

import 'package:mvvm_practice/models/counter.dart';

class CounterViewModel {
  final Counter _counter = Counter();
  final StreamController _streamController = StreamController();

  CounterViewModel() {
    _streamController.add(_counter.value);
  }

  int get counter => _counter.value;
  Stream get stream => _streamController.stream;

  void incrementCounter() {
    _streamController.add(++_counter.value);
  }
}
