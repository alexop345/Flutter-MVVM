import 'dart:async';

import 'package:mvvm_practice/models/counter.dart';
import 'package:rxdart/rxdart.dart';

class CounterViewModel {
  final Counter _counter = Counter();
  final BehaviorSubject<Counter> _behaviorSubject = BehaviorSubject<Counter>();

  CounterViewModel() {
    _behaviorSubject.add(_counter);
  }

  Stream get stream => _behaviorSubject.stream;
  Counter get counter => _counter;

  void incrementCounter() {
    _counter.value++;
    _behaviorSubject.add(_counter);
  }
}
