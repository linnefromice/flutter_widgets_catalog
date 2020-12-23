import 'package:flutter/material.dart';

class ListTileScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ListTileScreen> {
  bool _lights = false;
  bool _slowly = false;
  String _language = "Japanese";

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
          ),
          CheckboxListTile(
            title: Text("Animate Slowly"),
            secondary: Icon(Icons.hourglass_empty),
            value: _slowly,
            onChanged: (bool value) {
              setState(() {
                _slowly = value;
              });
            },
          ),
          RadioListTile(
            title: Text("Japanese"),
            value: "Japanese",
            groupValue: _language,
            onChanged: (String value) {
              setState(() {
                _language = value;
              });
            },
          ),
          RadioListTile(
            title: Text("English"),
            value: "English",
            groupValue: _language,
            onChanged: (String value) {
              setState(() {
                _language = value;
              });
            },
          ),
          RadioListTile(
            title: Text("Spanish"),
            value: "Spanish",
            groupValue: _language,
            onChanged: (String value) {
              setState(() {
                _language = value;
              });
            },
          ),
        ],
      ),
    );
  }
}