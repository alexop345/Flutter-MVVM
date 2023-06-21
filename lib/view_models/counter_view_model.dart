import 'package:flutter/material.dart';
import 'package:mvvm_practice/models/counter.dart';

class CounterViewModel extends ChangeNotifier {
  final Counter _counter = Counter();

  int get counter => _counter.value;

  void incrementCounter() {
    _counter.value++;
    notifyListeners();
  }
}
