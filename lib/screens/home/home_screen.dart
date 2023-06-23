import 'package:flutter/material.dart';
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
  Widget content = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    _setContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Home MVVM'),
      ),
      body: Center(
        child: content,
      ),
      floatingActionButton: content is CounterWidget
          ? FloatingActionButton(
              onPressed: () {
                _viewModel.input.onIncrement.add(true);
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _setContent() {
    _viewModel = HomeViewModel(
      Input(
        BehaviorSubject<bool>.seeded(false),
        PublishSubject<void>(),
      ),
    );

    _viewModel.output.onCountIncremented.listen((data) {
      setState(() {
        content = CounterWidget(data);
      });
    }, onError: (err) {
      setState(() {
        content = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(err),
            OutlinedButton(
                onPressed: () {
                  _viewModel.input.onReset.add(null);
                },
                child: const Text('Reset'))
          ],
        );
      });
    });

    _viewModel.output.onCountReset.listen((data) {
      setState(() {
        content = CounterWidget(data);
      });
    });
  }
}
