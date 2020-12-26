import 'package:flutter/material.dart';

class SliverAppBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("SliverAppBarScreen"),
            floating: true,
            flexibleSpace: Placeholder(),
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text("item ${index.toString()}"),
              ),
              childCount: 100
            ),
          )
        ],
      ),
    );
  }
}