import 'package:flutter/material.dart';

class GridViewScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<GridViewScreen> {
  int _selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget _selectBody(int index) {
    switch(index) {
      case 0:
        return _GridViewCount();
      case 1:
        return Center(
          child: Text("You are selected .builder"),
        );
      case 2:
        return Center(
          child: Text("You are selected .custom"),
        );
      case 3:
        return Center(
          child: Text("You are selected .extent"),
        );
      default:
        return Center(
          child: Text("Exception."),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectBody(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pinkAccent,
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
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