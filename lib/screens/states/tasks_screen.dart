import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
    Task(1, "DONE task", Status.DONE, "2020.12.25", "2020.12.25"),
    Task(2, "DOING task", Status.DOING, "2020.12.25", "2020.12.25"),
    Task(3, "READY task", Status.READY, "2020.12.25", "2020.12.25"),
    Task(4, "PENDING task", Status.PENDING, "2020.12.25", "2020.12.25"),
  ]);

  void create(final String title) {
    final _dateFormat = DateFormat('yyyy.MM.dd');

    state = [...state, Task(
      state.length + 1,
      title,
      Status.READY,
      _dateFormat.format(DateTime.now()),
      _dateFormat.format(DateTime.now()),
    )];
  }
}

class TasksScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _textController = useTextEditingController();
    final state = useProvider(_tasksProvider.state);
    final _provider = useProvider(_tasksProvider);

    return Scaffold(
      body: ListView.builder(
        itemCount: state.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Card(
              child: ListTile(
                leading: Text("New"),
                title: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Input new task title...',
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _provider.create(
                      _textController.text
                    );
                  },
                ),
              ),
            );
          } else {
            final task = state[index - 1];
            return Card(
              child: ListTile(
                leading: Icon(Icons.work),
                title: Text(task.title),
                subtitle: Text("${task.id.toString()} / ${task.status} / ${task.createDate}"),
              ),
            );
          }
        },
      )
    );
  }
}