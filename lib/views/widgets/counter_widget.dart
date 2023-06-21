import 'package:flutter/material.dart';
import 'package:mvvm_practice/models/counter.dart';

class CounterWidget extends StatelessWidget {
  final Counter counter;

  const CounterWidget(this.counter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('You have pushed the button this many times:'),
        Text(
          counter.value.toString(),
        ),
      ],
    );
  }
}
