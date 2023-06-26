import 'dart:async';

import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/repo/counter_repo.dart';
import 'package:mvvm_practice/repo/shared_pref_repo.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  final Input input;
  late Output output;
  final CounterRepo _counterRepo;

  HomeViewModel(this.input, {counterRepo})
      : _counterRepo = counterRepo ?? CounterRepo(sharedPref: SharedPrefRepo()) {
    Stream<Counter> increment = input.onIncrement.flatMap(
      (bool increment) {
        return _counterRepo.getCounter().flatMap((Counter counter) {
          if (counter.value >= 10) {
            return Stream.error('The counter has reached 10. Please reset.');
          }
          if (!increment) {
            return Stream.value(counter);
          }
          counter.value++;
          return _counterRepo.setCounter(counter);
        });
      },
    );

    Stream<Counter> reset = input.onReset.flatMap((_) {
      return _counterRepo.setCounter(Counter());
    });

    output = Output(MergeStream([increment, reset]));
  }

  dispose() {
    input.onIncrement.close();
    input.onReset.close();
  }
}

class Input {
  final Subject<bool> onIncrement;
  final Subject<void> onReset;

  Input(this.onIncrement, this.onReset);
}

class Output {
  final Stream<Counter> onCountResult;

  Output(this.onCountResult);
}
