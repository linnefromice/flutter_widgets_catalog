import 'package:flutter/material.dart';
import 'package:linnefromice/screens/grid_view_screen.dart';
import 'package:linnefromice/screens/interactive_viewer_screen.dart';
import 'package:linnefromice/screens/list_tile_screen.dart';
import 'package:linnefromice/screens/provider_practice_screen.dart';
import 'package:linnefromice/screens/sliver_app_bar_screen.dart';
import 'package:linnefromice/screens/tab_bar_view_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProviderPracticeScreen(),
    );
  }
}