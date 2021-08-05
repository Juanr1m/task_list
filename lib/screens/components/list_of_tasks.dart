import 'package:agrobank_test/repositories/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:agrobank_test/bloc/tasks/task_bloc.dart';
import '../edit_task.dart';

class ListOfTasks extends StatelessWidget {
  const ListOfTasks({
    Key? key,
    required this.tasks,
    required DateFormat dateFormatter,
    required this.color,
  })  : _dateFormatter = dateFormatter,
        super(key: key);

  final List<Task> tasks;
  final DateFormat _dateFormatter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        final task = tasks[index];
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Редактировать',
              color: Colors.black45,
              icon: Icons.edit,
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return EditTaskScreen(
                    task: task,
                    index: index,
                  );
                }))
              },
            ),
            IconSlideAction(
              caption: 'Удалить',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                BlocProvider.of<TaskBloc>(context)
                    .add(TaskDeleteEvent(index: index));
              },
            ),
          ],
          child: ListTile(
            tileColor: color,
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return EditTaskScreen(
                  task: task,
                  index: index,
                );
              }))
            },
            title: Text(task.title),
            subtitle:
                Text(_dateFormatter.format(task.date) + '  ' + task.status),
            trailing: Icon(Icons.more),
          ),
        );
      },
      itemCount: tasks.length,
    );
  }
}
