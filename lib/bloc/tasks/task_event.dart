part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// initial event
class TaskInitialEvent extends TaskEvent {}

// add event
class TaskAddEvent extends TaskEvent {
  final String title;
  final DateTime date;
  final String status;

  TaskAddEvent({required this.title, required this.date, required this.status});
}

// edit event
class TaskEditEvent extends TaskEvent {
  final String title;
  final DateTime date;
  final String status;
  final int? index;

  TaskEditEvent(
      {required this.date,
      required this.status,
      required this.title,
      required this.index});
}

// delete event
class TaskDeleteEvent extends TaskEvent {
  final int index;

  TaskDeleteEvent({required this.index});
}

class TaskfilterEvent extends TaskEvent {
  final bool isOrderToBig;

  TaskfilterEvent({required this.isOrderToBig});
}
