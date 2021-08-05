import 'dart:async';

import 'package:aliftech_test/repositories/di_locator.dart';
import 'package:aliftech_test/repositories/repository.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';

import 'package:aliftech_test/repositories/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DataRepository _taskDatabase = locator.get<DataRepository>();
  List<Task> _tasks = [];
  TaskBloc() : super(TaskInitial());

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is TaskInitialEvent) {
      yield* _mapInitialEventToState();
    }

    if (event is TaskAddEvent) {
      yield* _mapTaskAddEventToState(
          title: event.title, date: event.date, status: event.status);
    }

    if (event is TaskEditEvent) {
      yield* _mapTaskEditEventToState(
          title: event.title,
          date: event.date,
          status: event.status,
          index: event.index);
    }

    if (event is TaskDeleteEvent) {
      yield* _mapTaskDeleteEventToState(index: event.index);
    }

    if (event is TaskfilterEvent) {
      yield* _mapTaskFilterEventToState(isOrderToBig: event.isOrderToBig);
    }
  }

  // Stream Functions
  Stream<TaskState> _mapInitialEventToState() async* {
    yield TasksLoading();

    await _getTasks();

    yield AllTasksState(tasks: _tasks);
  }

  Stream<TaskState> _mapTaskAddEventToState(
      {required String title,
      required DateTime date,
      required String status}) async* {
    yield TasksLoading();
    await _addToTasks(title: title, date: date, status: status);
    yield AllTasksState(tasks: _tasks);
  }

  Stream<TaskState> _mapTaskEditEventToState(
      {required String title,
      required DateTime date,
      required String status,
      required int? index}) async* {
    yield TasksLoading();
    await _updateTask(
        newTitle: title, newStatus: status, newDate: date, index: index);
    yield AllTasksState(tasks: _tasks);
  }

  Stream<TaskState> _mapTaskDeleteEventToState({required int index}) async* {
    yield TasksLoading();
    await _removeFromTasks(index: index);
    _tasks.sort((a, b) {
      var aDate = a.title;
      var bDate = b.title;
      return aDate.compareTo(bDate);
    });
    yield AllTasksState(tasks: _tasks);
  }

  Stream<TaskState> _mapTaskFilterEventToState(
      {required bool isOrderToBig}) async* {
    yield TasksLoading();
    await _getTasks();
    if (isOrderToBig) {
      _tasks.sort((a, b) {
        var aDate = a.date;
        var bDate = b.date;
        return aDate.compareTo(bDate);
      });
    } else {
      _tasks.sort((a, b) {
        var aDate = a.date;
        var bDate = b.date;
        return bDate.compareTo(aDate);
      });
    }
    yield AllTasksState(tasks: _tasks);
  }

  // Helper Functions
  Future<void> _getTasks() async {
    await _taskDatabase.getFullTasks().then((value) {
      _tasks = value;
    });
  }

  Future<void> _addToTasks(
      {required String title,
      required DateTime date,
      required String status}) async {
    await _taskDatabase
        .addToBox(Task(title: title, date: date, status: status));
    await _getTasks();
  }

  Future<void> _updateTask(
      {required int? index,
      required String newTitle,
      required DateTime newDate,
      required String newStatus}) async {
    await _taskDatabase.updateTask(
        index!, Task(title: newTitle, date: newDate, status: newStatus));
    await _getTasks();
  }

  Future<void> _removeFromTasks({required int index}) async {
    await _taskDatabase.deleteFromBox(index);
    await _getTasks();
  }
}
