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
  String createDate; // yyyy.mm.dd
  String updateDate; // yyyy.mm.dd
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

  void updateStatus(final int id, final Status status) {
    final _dateFormat = DateFormat('yyyy.MM.dd');
    int oldTaskIndex;
    Task oldTask;
    print("Run updateStatus ... ${id.toString()} / ${status.toString()}");
    state.asMap().forEach((int index, Task element) {
      if (element.id == id) {
        oldTask = element;
        oldTaskIndex = index;
        return;
      }
    });
    state.removeAt(oldTaskIndex);
    state = [...state, Task(
      oldTask.id,
      oldTask.title,
      status,
      oldTask.createDate,
      _dateFormat.format(DateTime.now()),
    )];
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final TasksState _provider;

  TaskCard(this.task, this._provider);

  String convertStatusMessage(final Status status) {
    switch(status) {
      case Status.PENDING:
        return "保留";
      case Status.READY:
        return "着手可能";
      case Status.DOING:
        return "対応中";
      case Status.DONE:
        return "完了";
      default:
        return "UNKNOWN STATUS";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.work),
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ステータス: ${convertStatusMessage(task.status)}"),
            Text("作成日: ${task.createDate}"),
            Text("更新日: ${task.updateDate}"),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text(task.title),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        _provider.updateStatus(task.id, Status.PENDING);
                        Navigator.pop(context);
                      },
                      child: Text("保留"),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _provider.updateStatus(task.id, Status.READY);
                        Navigator.pop(context);
                      },
                      child: Text("着手可能"),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _provider.updateStatus(task.id, Status.DOING);
                        Navigator.pop(context);
                      },
                      child: Text("対応中"),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _provider.updateStatus(task.id, Status.DONE);
                        Navigator.pop(context);
                      },
                      child: Text("完了"),
                    ),
                  ],
                );
              }
            );
          },
        ),
      ),
    );
  }
}

class TasksScreen extends HookWidget {
  Widget _buildCreateArea(final TextEditingController _textController, final TasksState _provider) {
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
  }

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
            return _buildCreateArea(_textController, _provider);
          } else {
            return TaskCard(state[index - 1], _provider);
          }
        },
      )
    );
  }
}