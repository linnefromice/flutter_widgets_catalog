import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Status {
  PENDING,
  READY,
  DOING,
  DONE,
}

class Task {
  Task(
    this.id,
    this.title,
    this.status,
    this.createDate,
    this.updateDate
  );
  int id;
  String title;
  Status status;
  String createDate;
  String updateDate;
}

final _tasksProvider = StateNotifierProvider((_) => TasksState());

class TasksState extends StateNotifier<List<Task>> {
  TasksState() : super([
    Task(1, "DONE task", Status.DONE, "20201225", "20201225"),
    Task(2, "DOING task", Status.DOING, "20201225", "20201225"),
    Task(3, "READY task", Status.READY, "20201225", "20201225"),
    Task(4, "PENDING task", Status.PENDING, "20201225", "20201225"),
  ]);
}

class TasksScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(_tasksProvider.state);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter a search term'
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: state.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Card(
              child: ListTile(
                title: TextField(),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
              ),
            );
          } else {
            final task = state[index - 1];
            return Card(
              child: ListTile(
                leading: Icon(Icons.work),
                title: Text(task.title),
                subtitle: Text("${task.id.toString()} / ${task.createDate}"),
              ),
            );
          }
        },
      )
    );
  }
}