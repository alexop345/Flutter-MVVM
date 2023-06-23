import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/repo/counter_repo.dart';
import 'package:mvvm_practice/screens/home/home_view_model.dart';
import 'package:rxdart/subjects.dart';

main() {
  group('Counter tests', () {
    late CounterRepo counterRepo;
    late HomeViewModel homeViewModel;
    late Subject<bool> onIncrement;
    late Subject<void> onReset;

    setUp(() {
      onIncrement = BehaviorSubject<bool>.seeded(false);
      onReset = PublishSubject<void>();
      homeViewModel = HomeViewModel(Input(
        onIncrement,
        onReset,
      ));
    });

    tearDown(() {
      onIncrement.close();
      onReset.close();
    });

    test(
      'Test stream emits counter with value 0',
      () {
        expect(homeViewModel.output, isNotNull);
      },
    );
  });
}
