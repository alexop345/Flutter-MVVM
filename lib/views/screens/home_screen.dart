import 'package:flutter/material.dart';
import 'package:mvvm_practice/views/widgets/counter_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Home MVVM'),
      ),
      body: const Center(
        child: CounterWidget(),
      ),
    );
  }
}