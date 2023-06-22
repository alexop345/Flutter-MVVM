import 'dart:async';

import 'package:mvvm_practice/models/counter.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  final Input input;
  late Output output;
  final Counter _counter;

  HomeViewModel(this.input, {counterRepo}): _counter = counterRepo ?? Counter() {
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
