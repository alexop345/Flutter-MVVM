import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/repo/counter_repo.dart';
import 'package:mvvm_practice/screens/home/home_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../mocks/repos_mocks.dart';

main() {
  late CounterRepo repo;
  late HomeViewModel viewModel;
  late Subject<bool> onIncrement;
  late Subject<void> onReset;
  const String errorMessage = 'The counter has reached 10. Please reset.';

  setUp(() {
    repo = MockCounterRepo();
    onIncrement = BehaviorSubject<bool>.seeded(false);
    onReset = PublishSubject<void>();
    viewModel = HomeViewModel(
      Input(
        onIncrement,
        onReset,
      ),
      counterRepo: repo,
    );
  });

  tearDown(() {
    onIncrement.close();
    onReset.close();
  });

  test('should emit initial counter', () {
    Counter counter = Counter(value: 6);
    when(() => repo.getCounter()).thenAnswer((_) => Stream.value(counter));
    expect(viewModel.output.onCountResult, emits(counter));
  });

  test('should return error if initial value == 10', () {
    Counter counter = Counter(value: 10);
    when(() => repo.getCounter()).thenAnswer((_) => Stream.value(counter));
    expect(viewModel.output.onCountResult, emitsError(errorMessage));
  });

  test('should return error if incremented value reaches 10', () {
    Counter counter = Counter(value: 9);
    when(() => repo.getCounter()).thenAnswer((_) => Stream.value(counter));
    when(() => repo.setCounter(counter))
        .thenAnswer((_) => Stream.value(counter));
    viewModel.input.onIncrement.add(true);
    expect(viewModel.output.onCountResult, emitsError(errorMessage));
  });

  test('should increse counter value with 1', () {
    Counter counter = Counter(value: 6);
    when(() => repo.getCounter()).thenAnswer((_) => repo.setCounter(counter));
    when(() => repo.setCounter(counter))
        .thenAnswer((_) => Stream.value(counter));

    viewModel.input.onIncrement.add(true);
    expect(viewModel.output.onCountResult, emits(counter));
  });

  test('should set counter value to 0', () {
    Counter counter = Counter();
    when(() => repo.getCounter())
        .thenAnswer((_) => Stream.value(Counter(value: 4)));
    when(() => repo.setCounter(counter))
        .thenAnswer((_) => Stream.value(counter));

    viewModel.input.onReset.add(null);
    expect(viewModel.output.onCountResult, emits(counter));
  });
}
