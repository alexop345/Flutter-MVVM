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

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      Input(
        BehaviorSubject.seeded(false),
        PublishSubject(),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Home MVVM'),
      ),
      body: Center(
        child: StreamBuilder<Counter>(
          stream: _viewModel.output.onCountResult,
          builder: (ctx, snapshot) {
            if (snapshot.hasError || snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (snapshot.hasError) Text(snapshot.error as String),
                  if (snapshot.hasData) CounterWidget(snapshot.data!),
                  OutlinedButton(
                      onPressed: () {
                        _viewModel.input.onReset.add(null);
                      },
                      child: const Text('Reset'))
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.input.onIncrement.add(true);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
