import 'package:flutter/material.dart';
import 'package:mvvm_practice/models/counter.dart';
import 'package:mvvm_practice/screens/home/home_view_model.dart';
import 'package:mvvm_practice/widgets/counter_widget.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel _viewModel;
  Counter? counter;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(Input(PublishSubject<void>()));
    _viewModel.output.onCountIncremented.listen((Counter value) {
      setState(() {
        counter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Home MVVM'),
      ),
      body: Center(
        child: counter == null
            ? const CircularProgressIndicator()
            : CounterWidget(counter!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.input.onIncrement.add(null);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
