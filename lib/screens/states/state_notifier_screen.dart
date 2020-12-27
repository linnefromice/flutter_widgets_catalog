import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _counterProvider = StateNotifierProvider((_) => Counter());

class Counter extends StateNotifier<int> {
  Counter(): super(0);

  void increment() {
    state++;
  }
}

class StateNotifierScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, T Function<T>(ProviderBase<Object, T> provider) watch) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('StateNotifier'),
            Text('You have pushed the button this many times:'),
            Text("${watch(_counterProvider.state)}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read(_counterProvider).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}