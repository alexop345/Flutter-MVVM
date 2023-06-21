import 'dart:async';

import 'package:mvvm_practice/models/counter.dart';

class CounterViewModel {
  final Counter _counter = Counter();
  final StreamController _streamController = StreamController();

  CounterViewModel() {
    _streamController.add(_counter);
  }

  Stream get stream => _streamController.stream;

  void incrementCounter() {
    _counter.value++;
    _streamController.add(_counter);
  }
}