import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_proficiency_list_usecase.dart';
import 'proficiency_list_event.dart';
import 'proficiency_list_state.dart';

class ProficiencyListBloc extends Bloc<ProficiencyListEvent, ProficiencyListState> {
  final GetProficiencyListUsecase _getProficiencyListUsecase;

  ProficiencyListBloc({
    required GetProficiencyListUsecase getProficiencyListUsecase,
  })  : _getProficiencyListUsecase = getProficiencyListUsecase,
        super(const InitialProficiencyListState()) {
    on<ProficiencyListToWriteFeedbackEvent>(_getProficiencyList);
    on<SelectedStarCountFeedbackEvent>(_selectedStarCountFeedbackEvent);
  }

  Future<void> _selectedStarCountFeedbackEvent(
    SelectedStarCountFeedbackEvent _,
    Emitter<ProficiencyListState> emit,
  ) async {
    emit(state.loadingProficiencyListState());

    emit(state.emptyProficiencyListState());
  }

  Future<void> _getProficiencyList(
    ProficiencyListToWriteFeedbackEvent _,
    Emitter<ProficiencyListState> emit,
  ) async {
    emit(state.loadingProficiencyListState());

    final proficiencyList = await _getProficiencyListUsecase.call();

    proficiencyList.fold(
      (left) {
        emit(
          state.errorProficiencyListState(
            message: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyProficiencyListState());
        } else {
          emit(
            state.loadedProficiencyListState(
              proficiencyList: right,
            ),
          );
        }
      },
    );
  }
}
