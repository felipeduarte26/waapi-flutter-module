import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/failures/feedback_failure.dart';
import '../../../domain/usecases/get_feedback_by_id_usecase.dart';
import '../../../domain/usecases/set_feedback_private_usecase.dart';
import '../../../domain/usecases/set_feedback_public_usecase.dart';
import 'details_received_feedback_event.dart';
import 'details_received_feedback_state.dart';

class DetailsReceivedFeedbackBloc extends Bloc<DetailsReceivedFeedbackEvent, DetailsReceivedFeedbackState> {
  final SetFeedbackPrivateUsecase _setFeedbackPrivateUsecase;
  final SetFeedbackPublicUsecase _setFeedbackPublicUsecase;
  final GetFeedbackByIdUsecase _getFeedbackByIdUsecase;
  final AuthorizationBloc _authorizationBloc;

  DetailsReceivedFeedbackBloc({
    required SetFeedbackPublicUsecase setFeedbackPublicUsecase,
    required SetFeedbackPrivateUsecase setFeedbackPrivateUsecase,
    required GetFeedbackByIdUsecase getFeedbackByIdUsecase,
    required AuthorizationBloc authorizationBloc,
  })  : _setFeedbackPublicUsecase = setFeedbackPublicUsecase,
        _setFeedbackPrivateUsecase = setFeedbackPrivateUsecase,
        _getFeedbackByIdUsecase = getFeedbackByIdUsecase,
        _authorizationBloc = authorizationBloc,
        super(InitialDetailsReceivedFeedbacksState()) {
    on<GetReceivedFeedbackEvent>(_getReceivedFeedbackEvent);
    on<SetFeedbackPrivateEvent>(_setFeedbackPrivateEvent);
    on<SetFeedbackPublicEvent>(_setFeedbackPublicEvent);
  }

  Future<void> _setFeedbackPrivateEvent(
    SetFeedbackPrivateEvent event,
    Emitter<DetailsReceivedFeedbackState> emit,
  ) async {
    emit(LoadingDetailsReceivedFeedbacksState());

    final allowToToggleInternalFeedbackSharing =
        (_authorizationBloc.state as LoadedAuthorizationState).authorizationEntity.allowToToggleInternalFeedbackSharing;

    final setFeedbackPrivateUsecase = await _setFeedbackPrivateUsecase.call(
      isUserAllowedToToggleInternalFeedbackSharing: allowToToggleInternalFeedbackSharing,
      idFeedback: event.feedbackEntity.id,
    );

    setFeedbackPrivateUsecase.fold(
      (left) {
        emit(
          ErrorDetailsReceivedFeedbacksState(
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        emit(LoadedDetailsReceivedFeedbacksVisibilityState());
      },
    );
  }

  Future<void> _getReceivedFeedbackEvent(
    GetReceivedFeedbackEvent event,
    Emitter<DetailsReceivedFeedbackState> emit,
  ) async {
    emit(LoadingDetailsReceivedFeedbacksState());
    final receivedFeedback = await _getFeedbackByIdUsecase.call(
      feedbackId: event.receivedFeedbackId,
      feedbackType: event.feedbackType,
    );

    receivedFeedback.fold(
      (failure) {
        if (failure is FeedbackNotFoundFailure) {
          emit(ReceivedFeedbacksNotFoundState());
        } else {
          emit(
            ErrorDetailsReceivedFeedbacksState(
              errorMessage: failure.message,
            ),
          );
        }
      },
      (right) {
        emit(
          LoadedDetailsReceivedFeedbackState(
            receivedFeedbackEntity: right,
          ),
        );
      },
    );
  }

  Future<void> _setFeedbackPublicEvent(
    SetFeedbackPublicEvent event,
    Emitter<DetailsReceivedFeedbackState> emit,
  ) async {
    emit(LoadingDetailsReceivedFeedbacksState());

    final setFeedbackPublicEvent = await _setFeedbackPublicUsecase.call(
      isUserAllowedToToggleInternalFeedbackSharing: (_authorizationBloc.state as LoadedAuthorizationState)
          .authorizationEntity
          .allowToToggleInternalFeedbackSharing,
      idFeedback: event.feedbackEntity.id,
    );

    setFeedbackPublicEvent.fold(
      (left) {
        emit(
          ErrorDetailsReceivedFeedbacksState(
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        emit(LoadedDetailsReceivedFeedbacksVisibilityState());
      },
    );
  }
}
