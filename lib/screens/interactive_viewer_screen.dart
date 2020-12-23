import 'package:flutter/material.dart';

class InteractiveViewerScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<InteractiveViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(20.0),
          minScale: 0.1,
          maxScale: 2.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.blue[100], Colors.white]
              )
            ),
            child: Center(
              child: Text("InteractiveViewerScreen"),
            ),
          ),
        ),
      ),
    );
  }
}