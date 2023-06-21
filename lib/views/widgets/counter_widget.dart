import 'package:flutter/material.dart';
import 'package:mvvm_practice/view_models/counter_view_model.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counterVM = CounterViewModel();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('You have pushed the button this many times:'),
        StreamBuilder(
          stream: counterVM.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text(
              snapshot.data != null ? snapshot.data.toString() : "0",
            );
          },
        ),
        OutlinedButton(
          onPressed: counterVM.incrementCounter,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
