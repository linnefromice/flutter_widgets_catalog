import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _counterProvider = StateNotifierProvider((_) => Counter());

class Counter extends StateNotifier<int> {
  Counter(): super(0);

  void increment() {
    state++;
  }
}
class HooksRiverpodScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(_counterProvider.state);
    final counter = useProvider(_counterProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HooksRiverpod'),
            Text('You have pushed the button this many times:'),
            Text("${state}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}