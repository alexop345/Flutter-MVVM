import 'package:flutter/material.dart';
import 'package:mvvm_practice/view_models/counter_view_model.dart';
import 'package:mvvm_practice/views/widgets/counter_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterVM = CounterViewModel();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Home MVVM'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: counterVM.stream,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return CounterWidget(snapshot.data!);
            } 
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterVM.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
