part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

// initial
class TaskInitial extends TaskState {}

// loading
class TasksLoading extends TaskState {}

class EditTasksState extends TaskState {
  final Task task;

  EditTasksState({required this.task});
}

class AllTasksState extends TaskState {
  final List<Task> tasks;

  AllTasksState({required this.tasks});
}

class NewTaskState extends TaskState {}
