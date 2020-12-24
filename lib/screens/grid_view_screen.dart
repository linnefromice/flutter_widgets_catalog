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
      body: _GridViewCount(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: ".count"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: ".builder"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: ".custom"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_4),
            label: ".extent"
          ),
        ],
      ),
    );
  }
}

class _GridViewCount extends StatelessWidget {
  final List<Widget> _children = List.generate(10, (index) => Container(
    color: Colors.pink[index * 100],
    child: CircleAvatar(
      child: Text(index.toString()),
      backgroundColor: Colors.white,
    ),
  ));

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 3,
      children: _children
    );
  }
}