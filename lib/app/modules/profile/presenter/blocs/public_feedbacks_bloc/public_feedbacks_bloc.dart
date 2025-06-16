import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_public_feedbacks_usecase.dart';
import 'public_feedbacks_event.dart';
import 'public_feedbacks_state.dart';

class PublicFeedbacksBloc extends Bloc<PublicFeedbacksEvent, PublicFeedbacksState> {
  final GetPublicFeedbacksUsecase _getPublicFeedbacksUsecase;

  PublicFeedbacksBloc({required GetPublicFeedbacksUsecase getPublicFeedbacksUsecase})
      : _getPublicFeedbacksUsecase = getPublicFeedbacksUsecase,
        super(InitialPublicFeedbacksState()) {
    on<GetPublicFeedbacksEvent>(_getPublicFeedbacksEvent);
  }

  Future<void> _getPublicFeedbacksEvent(
    GetPublicFeedbacksEvent event,
    Emitter<PublicFeedbacksState> emit,
  ) async {
    final bool isAllowedToGetMorePublicFeedbacks = (state is! LoadingPublicFeedbacksState &&
        state is! LastPagePublicFeedbacksState &&
        state is! ErrorPublicFeedbacksState);

    if (!isAllowedToGetMorePublicFeedbacks) {
      return;
    }

    if (state.publicFeedbacks != null && state.publicFeedbacks!.isEmpty) {
      emit(
        state.loadingPublicFeedbacksState(),
      );
    } else {
      emit(
        state.loadingMorePublicFeedbacksState(),
      );
    }

    final publicFeedbacks = await _getPublicFeedbacksUsecase(
      employeeId: event.employeeId,
      paginationRequirements: event.paginationRequirements,
    );

    publicFeedbacks.fold((left) {
      emit(state.errorPublicFeedbacksState());
    }, (right) {
      if (right.isEmpty) {
        if (state.publicFeedbacks != null && state.publicFeedbacks!.isEmpty) {
          emit(state.emptyPublicFeedbacksState());
        } else {
          emit(
            state.lastPagePublicFeedbacksState(
              publicFeedbacks: state.publicFeedbacks!,
            ),
          );
        }
      } else {
        emit(
          state.loadedPagePublicFeedbacksState(
            publicFeedbacks: state.publicFeedbacks != null ? state.publicFeedbacks! + right : right,
          ),
        );
      }
    });
  }
}
