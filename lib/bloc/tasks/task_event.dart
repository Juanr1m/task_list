part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// initial event
class TaskInitialEvent extends TaskEvent {
  final int id;
  TaskInitialEvent({required this.id});
}

// add event
class TaskAddEvent extends TaskEvent {
  final String title;
  final DateTime date;
  final String status;
  final int id;

  TaskAddEvent(
      {required this.id,
      required this.title,
      required this.date,
      required this.status});
}

// edit event
class TaskEditEvent extends TaskEvent {
  final Task task, oldTask;

  TaskEditEvent({required this.task, required this.oldTask});
}

// delete event
class TaskDeleteEvent extends TaskEvent {
  final String title, date, status;

  TaskDeleteEvent(
    this.title,
    this.date,
    this.status,
  );
}

class TaskfilterEvent extends TaskEvent {
  final bool isOrderToBig;
  final int id;

  TaskfilterEvent({required this.isOrderToBig, required this.id});
}
