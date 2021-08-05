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
      yield* _mapInitialEventToState(event.id);
    }

    if (event is TaskAddEvent) {
      yield* _mapTaskAddEventToState(
          title: event.title,
          date: event.date,
          status: event.status,
          id: event.id);
    }

    if (event is TaskEditEvent) {
      yield* _mapTaskEditEventToState(
          title: event.title,
          date: event.date,
          status: event.status,
          index: event.index);
    }

    if (event is TaskDeleteEvent) {
      yield* _mapTaskDeleteEventToState(
          title: event.title, date: event.date, status: event.status);
    }

    if (event is TaskfilterEvent) {
      yield* _mapTaskFilterEventToState(
          isOrderToBig: event.isOrderToBig, id: event.id);
    }
  }

  // Stream Functions
  Stream<TaskState> _mapInitialEventToState(int id) async* {
    yield TasksLoading();

    await _getTasks(id);

    yield AllTasksState(tasks: _tasks);
  }

  Stream<TaskState> _mapTaskAddEventToState(
      {required String title,
      required DateTime date,
      required String status,
      required int id}) async* {
    yield TasksLoading();
    await _addToTasks(title: title, date: date, status: status, id: id);
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

  Stream<TaskState> _mapTaskDeleteEventToState(
      {required String title,
      required String date,
      required String status}) async* {
    yield TasksLoading();
    await _removeFromTasks(title: title, date: date, status: status);
    _tasks.sort((a, b) {
      var aDate = a.title;
      var bDate = b.title;
      return aDate.compareTo(bDate);
    });
    yield AllTasksState(tasks: _tasks);
  }

  Stream<TaskState> _mapTaskFilterEventToState(
      {required bool isOrderToBig, required int id}) async* {
    yield TasksLoading();
    await _getTasks(id);
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
  Future<void> _getTasks(int id) async {
    await _taskDatabase.getFullTasks(id).then((value) {
      _tasks = value;
    });
  }

  Future<void> _addToTasks(
      {required String title,
      required DateTime date,
      required String status,
      required int id}) async {
    await _taskDatabase
        .addToBox(Task(title: title, date: date, status: status));
    await _getTasks(id);
  }

  Future<void> _updateTask(
      {required int? index,
      required String newTitle,
      required DateTime newDate,
      required String newStatus}) async {
    await _taskDatabase.updateTask(
        index!, Task(title: newTitle, date: newDate, status: newStatus));
    await _getTasks(1);
  }

  Future<void> _removeFromTasks(
      {required String title,
      required String date,
      required String status}) async {
    await _taskDatabase.deleteFromBox(title, date, status);
    await _getTasks(1);
  }
}
