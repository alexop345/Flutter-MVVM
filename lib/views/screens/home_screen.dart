import 'package:flutter/material.dart';
import 'package:mvvm_practice/view_models/counter_view_model.dart';
import 'package:mvvm_practice/views/widgets/counter_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Home MVVM'),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (_) => CounterViewModel(),
          child: const CounterWidget(),
        ),
      ),
    );
  }
}
