import 'package:bloc/bloc.dart';

import 'tab_action_event.dart';
import 'tab_action_state.dart';

class TabActionBloc extends Bloc<TabActionEvent, TabActionState> {
  TabActionBloc() : super(tabActionInitialState) {
    on<ChangeTabActionEvent>(
      (event, emit) async {
        emit(
          TabActionState(
            tabIndex: event.tabIndexToChange,
          ),
        );
      },
    );
  }
}
