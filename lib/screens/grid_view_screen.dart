import 'package:flutter/material.dart';

class GridViewScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<GridViewScreen> {
  List<Widget> _children = List.generate(10, (index) => Container(
    color: Colors.pink[index * 100],
    child: CircleAvatar(
      child: Text(index.toString()),
      backgroundColor: Colors.white,
    ),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        children: _children
      ),
    );
  }
}