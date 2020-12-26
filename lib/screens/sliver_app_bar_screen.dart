import 'package:flutter/material.dart';

class SliverAppBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("SliverAppBarScreen")
          ),
        ],
      ),
    );
  }
}