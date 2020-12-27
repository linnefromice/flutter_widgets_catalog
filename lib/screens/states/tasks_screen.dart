import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Status {
  PENDING,
  READY,
  DOING,
  DONE,
}

class Task {
  Task({this.id, this.title, this.status, this.createDate, this.updateDate});
  int id;
  String title;
  Status status;
  String createDate;
  String updateDate;
}

class TasksScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Tasks"),
      ),
    );
  }
}