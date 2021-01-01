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

  void delete(final int id) {
    state.removeWhere((element) => element.id == id);
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final TasksState provider;

  TaskCard(this.task, this.provider);

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

  Widget _buildSubTitle(final Task _task) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ステータス: ${convertStatusMessage(_task.status)}"),
        Text("作成日: ${_task.createDate}"),
        Text("更新日: ${_task.updateDate}"),
      ],
    );
  }

  Widget _buildDialogOption(final BuildContext context, final TasksState _provider, final int _id, final Status _status, final String statusLabel) {
    return SimpleDialogOption(
      onPressed: () {
        _provider.updateStatus(_id, _status);
        Navigator.pop(context);
      },
      child: Text(statusLabel),
    );
  }

  Widget _buildDialog(final BuildContext context, final Task _task, final TasksState _provider) {
    return SimpleDialog(
      title: Text(_task.title),
      children: <Widget>[
        _buildDialogOption(
          context,
          _provider,
          _task.id,
          Status.PENDING,
          "保留"
        ),
        _buildDialogOption(
          context,
          _provider,
          _task.id,
          Status.READY,
          "着手可能"
        ),
        _buildDialogOption(
          context,
          _provider,
          _task.id,
          Status.DOING,
          "対応中"
        ),
        _buildDialogOption(
          context,
          _provider,
          _task.id,
          Status.DONE,
          "完了"
        ),
      ],
    );
  }

  Widget _buildTrailing(final BuildContext context, final Task _task, final TasksState _provider) {
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return _buildDialog(context, _task, _provider);
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.work),
        title: Text(task.title),
        subtitle: _buildSubTitle(task),
        trailing: _buildTrailing(context, task, provider)
      ),
    );
  }
}

class TasksScreen extends HookWidget {
  Widget _buildCreateArea(final TextEditingController _textController, final TasksState _provider) {
    return Card(
      child: ListTile(
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
            _textController.clear();
          },
        ),
      ),
    );
  }

  Future<bool> _isDismiss(final BuildContext context, final Task task) async {
    return await showDialog(
        context: context,
        builder: (_) {
        return AlertDialog(
          title: Text("削除しますか？"),
          content: Text("対象: ${task.title}"),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      }
    );
  }

  void _displayModifyTaskDialog(final BuildContext context, final TextEditingController _textController, final Task task) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("タイトル修正"),
              Text("現状: ${task.title}"),
            ],
          ),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Input new title of this task ...',
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text("MODIFY"),
              onPressed: () {
                print(_textController.text); // TODO: update state
                _textController.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final _textController = useTextEditingController();
    final _titleController = useTextEditingController();
    final state = useProvider(_tasksProvider.state);
    final _provider = useProvider(_tasksProvider);

    return Scaffold(
      body: ListView.builder(
        itemCount: state.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildCreateArea(_textController, _provider);
          } else {
            final Task task = state[index - 1];
            return Dismissible(
              key: Key("${task.id}"),
              background: Container(color: Colors.blue, child: Icon(Icons.edit)),
              secondaryBackground: Container(color: Colors.red, child: Icon(Icons.close)),
              confirmDismiss: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  _displayModifyTaskDialog(context, _titleController, task);
                  return Future.value(false);
                } else {
                  return _isDismiss(context, task);
                }
              },
              onDismissed: (direction) {
                _provider.delete(task.id);
              },
              child: TaskCard(task, _provider),
            );
          }
        },
      )
    );
  }
}