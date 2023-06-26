import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/repo/counter_repo.dart';
import 'package:mvvm_practice/screens/home/home_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/repos_mocks.dart';

main() {
  group('Counter tests', () {
    late CounterRepo repo;
    late HomeViewModel viewModel;
    late Subject<bool> onIncrement;
    late Subject<void> onReset;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});

      onIncrement = BehaviorSubject<bool>.seeded(false);
      onReset = PublishSubject<void>();
      viewModel = HomeViewModel(Input(
        onIncrement,
        onReset,
      ));
      repo = MockCounterRepo();
    });

    tearDown(() {
      onIncrement.close();
      onReset.close();
    });

    test(
      'Test stream emits counter with value 0',
      () {
        when(() => repo.getCounter()).thenAnswer((_) => Stream.value(Counter()));
        expect(viewModel.input, isNotNull);
        expect(viewModel.output, isNotNull);
        viewModel.output.onCountResult.listen(
          (event) {
            expect(event.value, 0);
          },
        );
      },
    );

    test(
      'Test stream emits counter with value 1',
      () {
        when(() => repo.getCounter()).thenAnswer((_) => Stream.value(Counter()));
        expect(viewModel.input, isNotNull);
        expect(viewModel.output, isNotNull);
        viewModel.input.onIncrement.add(true);
        viewModel.output.onCountResult.listen(
          (event) {
            expect(event.value, 1);
          },
        );
      },
    );
  });
}
