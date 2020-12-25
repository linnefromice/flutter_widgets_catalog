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
        return _GridViewBuilder();
      case 2:
        return _GridViewExtent();
      case 3:
        return _GridViewCustom();
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
            label: ".extent"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_4),
            label: ".custom"
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

class _GridViewBuilder extends StatelessWidget {
  final List<Widget> _children = List.generate(10, (index) => Container(
    color: Colors.blue[index * 100],
    child: CircleAvatar(
      child: Text(index.toString()),
      backgroundColor: Colors.white,
    ),
  ));

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3
      ),
      itemBuilder: (context, index) {
        if (index >= widgets.length) {
          widgets.addAll(_children);
        }
        return widgets[index];
      },
    );
  }
}

class _GridViewExtent extends StatelessWidget {
  final List<Widget> _children = List.generate(10, (index) => Container(
    color: Colors.green[index * 100],
    child: CircleAvatar(
      child: Text(index.toString()),
      backgroundColor: Colors.white,
    ),
  ));

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      padding: EdgeInsets.all(8),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _children,
    );
  }
}

class _GridViewCustom extends StatelessWidget {
  final List<Widget> _children = List.generate(10, (index) => Container(
    color: Colors.yellow[index * 100],
    child: CircleAvatar(
      child: Text(index.toString()),
      backgroundColor: Colors.white,
    ),
  ));

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4.0,
      ),
      childrenDelegate: SliverChildListDelegate(
        _children
      ),
    );
  }
}