import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/view_models/counter_view_model.dart';

main() {
  group('Counter tests', () {
    late CounterViewModel counterVM;
    setUp(() {
      counterVM = CounterViewModel();
    });
    test(
      'Test stream emits counter with value 0',
      () {
        final stream = counterVM.stream;
        final Counter counter = counterVM.counter;

        expect(stream, emits(counter));
        expect(counter.value, 0);
      },
    );

    test(
      'Test increment counter',
      () {
        final Counter counter = counterVM.counter;

        counterVM.incrementCounter();
        expect(counter.value, 1);
      },
    );
  });
}
