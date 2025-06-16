import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/failures/happiness_index_failure.dart';
import '../../../domain/usecases/retrieve_all_reasons_happiness_index_usecase.dart';
import 'retrieve_all_reasons_event.dart';
import 'retrieve_all_reasons_state.dart';

class RetrieveAllReasonsBloc extends Bloc<RetrieveAllReasonsEvent, RetrieveAllReasonsState> {
  final RetrieveAllReasonsHappinessIndexUsecase _retrieveAllReasonsUsecase;

  RetrieveAllReasonsBloc({
    required RetrieveAllReasonsHappinessIndexUsecase retrieveAllReasonsUsecase,
  })  : _retrieveAllReasonsUsecase = retrieveAllReasonsUsecase,
        super(const EmptyRetrieveAllReasonsState()) {
    on<GetRetrieveAllReasonsEvent>(_getRetrieveAllReasonsEvent);
  }

  Future<void> _getRetrieveAllReasonsEvent(
    GetRetrieveAllReasonsEvent event,
    Emitter<RetrieveAllReasonsState> emit,
  ) async {
    emit(const LoadingRetrieveAllReasonsState());

    final happinessIndexGroupEntities = await _retrieveAllReasonsUsecase.call(
      language: event.language,
    );

    happinessIndexGroupEntities.fold(
      (error) {
        if (error is RetrieveAllReasonsHappinessIndexFailure) {
          emit(const EmptyRetrieveAllReasonsState());
          return;
        }
        emit(
          ErrorRetrieveAllReasonsState(
            message: error.message,
          ),
        );
      },
      (right) {
        emit(
          LoadedRetrieveAllReasonsState(
            groupList: right,
          ),
        );
      },
    );
  }
}
