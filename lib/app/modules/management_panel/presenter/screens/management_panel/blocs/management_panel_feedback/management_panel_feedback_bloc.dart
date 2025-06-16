import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../feedback/domain/usecases/get_latest_feedbacks_usecase.dart';
import 'management_panel_feedback_event.dart';
import 'management_panel_feedback_state.dart';

class ManagementPanelFeedbackBloc extends Bloc<ManagementPanelFeedbackEvent, ManagementPanelFeedbackState> {
  final GetLatestFeedbacksUsecase _getLatestFeedbacksUsecase;
  ManagementPanelFeedbackBloc({
    required GetLatestFeedbacksUsecase getLatestFeedbacksUsecase,
  })  : _getLatestFeedbacksUsecase = getLatestFeedbacksUsecase,
        super(InitialManagementPanelLatestFeedbacksState()) {
    on<GetLatestFeedbacksEvent>(_latestFeedbacksEvent);
  }

  Future<void> _latestFeedbacksEvent(
    GetLatestFeedbacksEvent event,
    Emitter<ManagementPanelFeedbackState> emit,
  ) async {
    emit(LoadingManagementPanelLatestFeedbacksState());

    final latestFeedbacksUsecaseResult = await _getLatestFeedbacksUsecase(
      isUserAllowedToViewMyFeedbacks: event.isAllowToViewMyFeedbacks,
    );

    latestFeedbacksUsecaseResult.fold(
      (left) {
        emit(
          ErrorManagementPanelLatestFeedbacksState(
            message: left.message,
          ),
        );
      },
      (right) {
        if (right.isNotEmpty) {
          emit(
            LoadedManagementPanelLatestFeedbacksState(
              latestFeedbacks: right,
            ),
          );
        } else {
          emit(EmptyManagementPanelLatestFeedbacksState());
        }
      },
    );
  }
}
