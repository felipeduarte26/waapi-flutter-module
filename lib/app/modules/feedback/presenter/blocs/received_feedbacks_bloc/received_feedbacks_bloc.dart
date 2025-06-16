import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/usecases/get_received_feedbacks_usecase.dart';
import 'received_feedbacks_event.dart';
import 'received_feedbacks_state.dart';

class ReceivedFeedbacksBloc extends Bloc<ReceivedFeedbacksEvent, ReceivedFeedbacksState> {
  final GetReceivedFeedbacksUsecase _getReceivedFeedbacksUsecase;
  final AuthorizationBloc _authorizationBloc;

  ReceivedFeedbacksBloc({
    required GetReceivedFeedbacksUsecase getReceivedFeedbacksUsecase,
    required AuthorizationBloc authorizationBloc,
  })  : _getReceivedFeedbacksUsecase = getReceivedFeedbacksUsecase,
        _authorizationBloc = authorizationBloc,
        super(const InitialReceivedFeedbacksState()) {
    on<GetReceivedFeedbacksEvent>(_getReceivedFeedbacksEvent);
    on<ReloadListReceivedFeedbacksEvent>(_reloadListReceivedFeedbacksEvent);
  }

  Future<void> _reloadListReceivedFeedbacksEvent(
    ReloadListReceivedFeedbacksEvent _,
    Emitter<ReceivedFeedbacksState> emit,
  ) async {
    emit(ReloadListReceivedFeedbacksState());
  }

  Future<void> _getReceivedFeedbacksEvent(
    GetReceivedFeedbacksEvent event,
    Emitter<ReceivedFeedbacksState> emit,
  ) async {
    final bool isAllowedToGetMoreFeedbacks = (state is! LoadingMoreReceivedFeedbacksState &&
            state is! LastPageReceivedFeedbacksState &&
            state is! ErrorReceivedFeedbacksState) ||
        event.overrideNotAllowedStates;

    if (!isAllowedToGetMoreFeedbacks) {
      return;
    }

    if (state.receivedFeedbacks.isEmpty) {
      emit(state.loadingReceivedFeedbacksState());
    } else {
      emit(state.loadingMoreReceivedFeedbacksState());
    }

    final receivedFeedbacks = await _getReceivedFeedbacksUsecase.call(
      isUserAllowedToViewMyFeedbacks:
          (_authorizationBloc.state as LoadedAuthorizationState).authorizationEntity.allowToViewMyFeedbacks,
      paginationRequirements: event.paginationRequirements,
    );

    receivedFeedbacks.fold(
      (left) {
        emit(
          state.errorReceivedFeedbacksState(
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          if (state.receivedFeedbacks.isEmpty) {
            emit(state.emptyListReceivedFeedbacksState());
          } else {
            emit(
              state.lastPageReceivedFeedbacksState(
                receivedFeedbacks: state.receivedFeedbacks,
              ),
            );
          }
        } else {
          emit(
            state.loadedReceivedFeedbacksState(
              receivedFeedbacks: state.receivedFeedbacks + right,
            ),
          );
        }
      },
    );
  }
}
