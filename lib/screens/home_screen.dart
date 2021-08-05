import 'package:aliftech_test/bloc/bottom_navigation/bottomnavigation_bloc.dart';

import 'package:aliftech_test/bloc/tasks/task_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'add_task.dart';
import 'components/appbar.dart';
import 'components/bottom_nav_bar.dart';
import 'components/list_of_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomnavigationBloc? _navbarBloc;
  final DateFormat _dateFormatter = DateFormat('MMM dd');

  @override
  void initState() {
    super.initState();
    _navbarBloc = BottomnavigationBloc();
  }

  @override
  void dispose() {
    _navbarBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _navbarBloc,
      builder: (BuildContext context, BottomnavigationState state) {
        if (state is ShowAll) return buildHomepage(state.itemIndex);
        if (state is ShowTasksInProgress) return buildHomepage(state.itemIndex);
        if (state is ShowDoneTasks) return buildHomepage(state.itemIndex);
        return CircularProgressIndicator();
      },
    );
  }

  Scaffold buildHomepage(int currentIndex) {
    return Scaffold(
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is AllTasksState) {
            final tasks = state.tasks;
            if (state.tasks.isEmpty) {
              return Center(
                child: Text('Нет информации'),
              );
            }
            if (_navbarBloc!.state is ShowAll) {
              return ListOfTasks(
                tasks: tasks,
                dateFormatter: _dateFormatter,
                color: Colors.transparent,
              );
            }

            if (_navbarBloc!.state is ShowTasksInProgress) {
              final progressTasks = state.tasks
                  .where((element) => element.status == 'В прогрессе')
                  .toList();
              if (progressTasks.isEmpty) {
                return Center(
                  child: Text('Нет информации'),
                );
              }
              return ListOfTasks(
                tasks: progressTasks,
                dateFormatter: _dateFormatter,
                color: Colors.red.shade50,
              );
            }
            if (_navbarBloc!.state is ShowDoneTasks) {
              final doneTasks = state.tasks
                  .where((element) => element.status == 'Выполнено')
                  .toList();

              if (doneTasks.isEmpty) {
                return Center(
                  child: Text('Нет информации'),
                );
              }
              return ListOfTasks(
                tasks: doneTasks,
                dateFormatter: _dateFormatter,
                color: Colors.green,
              );
            }
          }
          if (state is TasksLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SizedBox();
          }
        },
      ),
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => AddTaskScreen(),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        navbarBloc: _navbarBloc,
        currentIndex: currentIndex,
      ),
    );
  }
}
