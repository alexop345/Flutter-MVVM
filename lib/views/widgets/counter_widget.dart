import 'package:flutter/material.dart';
import 'package:mvvm_practice/view_models/counter_view_model.dart';

final counterVM = CounterViewModel();

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('You have pushed the button this many times:'),
        StreamBuilder(
          stream: counterVM.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text(
              snapshot.data.toString(),
            );
          },
        ),
      ],
    );
  }
}
