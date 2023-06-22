import 'dart:async';

import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/repo/counter_repo.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  final Input input;
  late Output output;
  final CounterRepo _counterRepo;

  HomeViewModel(this.input, {counterRepo})
      : _counterRepo = counterRepo ?? CounterRepo() {
    Stream<Counter> onCountIncremented = input.onIncrement.flatMap(
      (_) {
        return _counterRepo.getCounter().flatMap((Counter counter) {
          counter.value++;
          return _counterRepo.setCounter(counter).flatMap((Counter counter) {
            if (counter.value >= 10) {
              return Stream.error('The counter has reached 10. Please reset.');
            }
            return Stream.value(counter);
          });
        });
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
