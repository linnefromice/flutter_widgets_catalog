import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterModel extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}

class ProviderPracticeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              CounterText(),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      Provider.of<CounterModel>(context).count.toString(),
      style: Theme.of(context).textTheme.headline3,
    );
  }
}