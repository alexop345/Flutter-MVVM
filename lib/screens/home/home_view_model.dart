import 'dart:async';
import 'dart:convert';

import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/repo/counter_repo.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  final Input input;
  late Output output;
  final Counter _counter = Counter();
  final CounterRepo _counterRepo;

  HomeViewModel(this.input, {counterRepo}): _counterRepo = counterRepo ?? CounterRepo() {
   
    Stream<Counter> onCountIncremented = input.onIncrement.flatMap(
      (_) {
        _counter.value++;
        return Stream.value(_counter);
      },
    );
    output = Output(onCountIncremented);
  }
}

class Input {
  final Subject<void> onIncrement;

  Input(this.onIncrement);
}

class Output {
  final Stream<Counter> onCountIncremented;

  Output(this.onCountIncremented);
}
