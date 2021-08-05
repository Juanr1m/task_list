import 'package:aliftech_test/bloc/tasks/task_bloc.dart';
import 'package:aliftech_test/screens/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'add_task.dart';
import 'components/list_of_tasks.dart';

class DoneTaskScreen extends StatefulWidget {
  @override
  _DoneTaskScreenState createState() => _DoneTaskScreenState();
}

class _DoneTaskScreenState extends State<DoneTaskScreen> {
  TaskBloc? bloc;
  final DateFormat _dateFormatter = DateFormat('MMM dd');

  @override
  void initState() {
    bloc = BlocProvider.of<TaskBloc>(context);
    bloc!.add(TaskInitialEvent(id: 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => AddTaskScreen(id: 3),
            ),
          );
        },
      ),
      appBar: buildAppBar(context, 3),
      body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
        if (state is AllTasksState) {
          final tasks = state.tasks;
          if (state.tasks.isEmpty) {
            return Center(
              child: Text('Нет информации'),
            );
          }

          return ListOfTasks(
            tasks: tasks,
            dateFormatter: _dateFormatter,
            color: Colors.transparent,
          );
        }

        if (state is TasksLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
