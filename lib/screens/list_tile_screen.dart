import 'package:flutter/material.dart';

class ListTileScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ListTileScreen> {
  bool _lights = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("Lights"),
            secondary: Icon(Icons.lightbulb_outline),
            value: _lights,
            onChanged: (bool value) {
              setState(() {
                _lights = value;
              });
            },
          )
        ],
      ),
    );
  }
}