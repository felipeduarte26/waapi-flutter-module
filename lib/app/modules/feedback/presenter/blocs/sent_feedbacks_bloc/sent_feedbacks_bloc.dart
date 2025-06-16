import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/usecases/get_sent_feedbacks_usecase.dart';
import 'sent_feedbacks_event.dart';
import 'sent_feedbacks_state.dart';

class SentFeedbacksBloc extends Bloc<SentFeedbacksEvent, SentFeedbacksState> {
  final GetSentFeedbacksUsecase _getSentFeedbacksUsecase;
  final AuthorizationBloc _authorizationBloc;

  SentFeedbacksBloc({
    required AuthorizationBloc authorizationBloc,
    required GetSentFeedbacksUsecase getSentFeedbacksUsecase,
  })  : _authorizationBloc = authorizationBloc,
        _getSentFeedbacksUsecase = getSentFeedbacksUsecase,
        super(const InitialSentFeedbacksState()) {
    on<GetSentFeedbacksEvent>(_getSentFeedbacks);
    on<ReloadListSentFeedbacksEvent>(_reloadListSentFeedbacksEvent);
  }

  Future<void> _reloadListSentFeedbacksEvent(
    ReloadListSentFeedbacksEvent _,
    Emitter<SentFeedbacksState> emit,
  ) async {
    emit(ReloadListSentFeedbacksState());
  }

  Future<void> _getSentFeedbacks(
    GetSentFeedbacksEvent event,
    Emitter<SentFeedbacksState> emit,
  ) async {
    final bool isAllowedToGetMoreFeedbacks = (state is! LoadingMoreSentFeedbacksState &&
            state is! LastPageSentFeedbacksState &&
            state is! ErrorSentFeedbacksState) ||
        event.overrideNotAllowedStates;

    if (!isAllowedToGetMoreFeedbacks) {
      return;
    }

    if (state.sentFeedbacks.isEmpty) {
      emit(state.loadingSentFeedbacksState());
    } else {
      emit(state.loadingMoreSentFeedbacksState());
    }

    final sentFeedbacks = await _getSentFeedbacksUsecase.call(
      isUserAllowedToViewMyFeedbacks:
          (_authorizationBloc.state as LoadedAuthorizationState).authorizationEntity.allowToViewMyFeedbacks,
      paginationRequirements: event.paginationRequirements,
    );

    sentFeedbacks.fold(
      (left) {
        emit(
          state.errorSentFeedbacksState(
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          if (state.sentFeedbacks.isEmpty) {
            emit(state.emptyListSentFeedbacksState());
          } else {
            emit(
              state.lastPageSentFeedbacksState(
                sentFeedbacks: state.sentFeedbacks,
              ),
            );
          }
        } else {
          emit(
            state.loadedSentFeedbacksState(
              sentFeedbacks: state.sentFeedbacks + right,
            ),
          );
        }
      },
    );
  }
}
