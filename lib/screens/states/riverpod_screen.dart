import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _counterProvider = ChangeNotifierProvider((ref) => Counter());

class Counter extends ChangeNotifier {
  var _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class RiverpodScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, T Function<T>(ProviderBase<Object, T> provider) watch) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Riverpod'),
            Text('You have pushed the button this many times:'),
            Text("${watch(_counterProvider).count}"),
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