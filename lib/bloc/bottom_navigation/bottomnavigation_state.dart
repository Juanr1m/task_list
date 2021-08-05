part of 'bottomnavigation_bloc.dart';

@immutable
abstract class BottomnavigationState {}

class ShowAll extends BottomnavigationState {
  final String title = 'Все';
  final int itemIndex = 0;
}

class ShowTasksInProgress extends BottomnavigationState {
  final String title = 'В прогрессе';
  final int itemIndex = 1;
}

class ShowDoneTasks extends BottomnavigationState {
  final String title = 'Выполнено';
  final int itemIndex = 2;
}
