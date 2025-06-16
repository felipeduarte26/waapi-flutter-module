import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/get_user_info_feedback_usecase.dart';
import 'user_info_feedback_event.dart';
import 'user_info_feedback_state.dart';

class UserInfoFeedbackBloc extends Bloc<UserInfoFeedbackEvent, UserInfoFeedbackState> {
  final GetUserInfoFeedbackUsecase _getUserInfoFeedbackUsecase;

  UserInfoFeedbackBloc({
    required GetUserInfoFeedbackUsecase getUserInfoFeedbackUsecase,
  })  : _getUserInfoFeedbackUsecase = getUserInfoFeedbackUsecase,
        super(const InitialUserInfoFeedbackState()) {
    on<UserInfoToWriteFeedbackEvent>(
      _getUserInfo,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );
    on<UnSelectedUserFeedbackEvent>(_unSelectedUserFeedbackEvent);
    on<ClearUserInfoFeedbackEvent>(_clearSearchProficiencyFeedbackEvent);
  }

  Future<void> _clearSearchProficiencyFeedbackEvent(
    ClearUserInfoFeedbackEvent _,
    Emitter<UserInfoFeedbackState> emit,
  ) async {
    emit(state.initialUserInfoFeedbackState());
  }

  Future<void> _unSelectedUserFeedbackEvent(
    UnSelectedUserFeedbackEvent _,
    Emitter<UserInfoFeedbackState> emit,
  ) async {
    emit(const InitialUserInfoFeedbackState());
  }

  Future<void> _getUserInfo(
    UserInfoToWriteFeedbackEvent event,
    Emitter<UserInfoFeedbackState> emit,
  ) async {
    final isInvalidId = event.userId.trim().length < 3;

    if (isInvalidId) {
      emit(state.initialUserInfoFeedbackState());
      return;
    }

    emit(state.loadingUserInfoFeedbackState());

    final userInfo = await _getUserInfoFeedbackUsecase.call(
      userId: event.userId,
    );

    userInfo.fold(
      (left) {
        emit(
          state.errorUserInfoFeedbackState(
            message: left.message,
          ),
        );
      },
      (right) {
        if (right.id.isEmpty) {
          emit(state.emptyStateUserInfoFeedbacksState());
        } else {
          emit(
            state.loadedUserInfoFeedbackState(
              userInfoFeedback: right,
            ),
          );
        }
      },
    );
  }

  EventTransformer<UserInfoToWriteFeedbackEvent> debounce<GetCompetencesEvent>(Duration duration) {
    return (events, mapper) {
      return events
          .debounceTime(
            duration,
          )
          .flatMap(
            mapper,
          );
    };
  }
}
