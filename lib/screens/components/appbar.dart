import 'package:aliftech_test/bloc/tasks/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar buildAppBar(BuildContext context, int id) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton(
          icon: Icon(Icons.settings),
          onChanged: (_) {},
          items: [
            DropdownMenuItem(
              value: 'В порядке возрастания сроков',
              child: Text('В порядке возрастания сроков'),
              onTap: () {
                BlocProvider.of<TaskBloc>(context)
                    .add(TaskfilterEvent(isOrderToBig: true, id: id));
              },
            ),
            DropdownMenuItem(
              value: 'В порядке убывания сроков',
              child: Text('В порядке убывания сроков'),
              onTap: () {
                BlocProvider.of<TaskBloc>(context)
                    .add(TaskfilterEvent(isOrderToBig: false, id: id));
              },
            ),
          ],
        ),
      )
    ],
    title: Text('Задачи'),
  );
}
