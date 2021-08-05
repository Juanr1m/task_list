import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'bottomnavigation_event.dart';

part 'bottomnavigation_state.dart';

class BottomnavigationBloc extends Bloc<NavbarItems, BottomnavigationState> {
  BottomnavigationBloc() : super(ShowAll());

  @override
  Stream<BottomnavigationState> mapEventToState(
    NavbarItems event,
  ) async* {
    switch (event) {
      case NavbarItems.Progress:
        yield ShowTasksInProgress();
        break;
      case NavbarItems.Done:
        yield ShowDoneTasks();
        break;
      default:
        yield ShowAll();
        break;
    }
  }
}
