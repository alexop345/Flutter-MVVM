import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/screens/home/home_view_model.dart';

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
        final Counter counter = Counter();

        expect(stream, emits(counter));
        expect(counter.value, 0);
      },
    );

    test(
      'Test increment counter',
      () {
        final Counter counter = Counter();

        counterVM.incrementCounter();
        expect(counter.value, 1);
      },
    );
  });
}
