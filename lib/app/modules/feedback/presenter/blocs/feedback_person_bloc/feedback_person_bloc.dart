import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../profile/domain/usecases/get_person_id_usecase.dart';
import 'feedback_person_event.dart';
import 'feedback_person_state.dart';

class FeedbackPersonBloc extends Bloc<FeedbackPersonEvent, FeedbackPersonState> {
  final GetPersonIdUsecase _getPersonIdUsecase;

  FeedbackPersonBloc({
    required GetPersonIdUsecase getPersonIdUsecase,
  })  : _getPersonIdUsecase = getPersonIdUsecase,
        super(InitialFeedbackPersonState()) {
    on<GetFeedbackPersonIdEvent>(_getFeedbackPersonIdEvent);
  }

  Future<void> _getFeedbackPersonIdEvent(
    GetFeedbackPersonIdEvent event,
    Emitter<FeedbackPersonState> emit,
  ) async {
    emit(LoadingFeedbackPersonState());

    final personId = await _getPersonIdUsecase.call(
      employeeId: event.employeeId,
    );

    personId.fold(
      (left) {
        emit(
          ErrorFeedbackPersonState(),
        );
      },
      (right) {
        emit(
          LoadedFeedbackPersonState(
            personId: right,
          ),
        );
      },
    );
  }
}
