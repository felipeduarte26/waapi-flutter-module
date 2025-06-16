import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_already_viewed_onboarding_usecase.dart';
import '../../../domain/usecases/open_external_url_usecase.dart';
import '../../../domain/usecases/save_already_viewed_onboarding_usecase.dart';
import '../../../domain/usecases/set_onboarding_jump_usecase.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetAlreadyViewedOnboardingUsecase _getAlreadyViewedOnboardingUsecase;
  final SaveAlreadyViewedOnboardingUsecase _saveAlreadyViewedOnboardingUsecase;
  final SetOnboardingJumpUsecase _setOnboardingJumpUsecase;
  final OpenExternalUrlUsecase _openExternalUrlUsecase;

  OnboardingBloc({
    required GetAlreadyViewedOnboardingUsecase getAlreadyViewedOnboardingUsecase,
    required SaveAlreadyViewedOnboardingUsecase saveAlreadyViewedOnboardingUsecase,
    required SetOnboardingJumpUsecase setOnboardingJumpUsecase,
    required OpenExternalUrlUsecase openExternalUrlUsecase,
  })  : _getAlreadyViewedOnboardingUsecase = getAlreadyViewedOnboardingUsecase,
        _saveAlreadyViewedOnboardingUsecase = saveAlreadyViewedOnboardingUsecase,
        _setOnboardingJumpUsecase = setOnboardingJumpUsecase,
        _openExternalUrlUsecase = openExternalUrlUsecase,
        super(InitialOnboardingState()) {
    on<SaveAlreadyViewedOnboardingEvent>(_saveAlreadyViewedOnboardingEvent);
    on<GetAlreadyViewedOnboardingEvent>(_getAlreadyViewedOnboardingEvent);
    on<SetOnboardingJumpEvent>(_setOnboardingJumpEvent);
    on<OpenExternalUrlEvent>(_openExternalUrlEvent);
    on<NextPageOnboardingEvent>(_nextPageOnboardingEvent);
  }

  Future<void> _saveAlreadyViewedOnboardingEvent(
    SaveAlreadyViewedOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.loadingOnboardingState());

    final saveAlreadyViewed = await _saveAlreadyViewedOnboardingUsecase.call(
      onboardingViewKeyEnum: event.onboardingViewKeyEnum,
      visualized: event.visualized,
    );

    saveAlreadyViewed.fold(
      (_) {
        emit(state.errorOnboardingState());
      },
      (_) {
        emit(state.visualizedOnboardingState());
      },
    );
  }

  Future<void> _getAlreadyViewedOnboardingEvent(
    GetAlreadyViewedOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    if (event.isReview) {
      emit(state.notVisualizedOnboardingState());
      return;
    }

    emit(state.loadingOnboardingState());

    final statusOnboarding = await _getAlreadyViewedOnboardingUsecase.call(
      onboardingViewKeyEnum: event.onboardingViewKeyEnum,
    );

    statusOnboarding.fold(
      (_) {
        emit(state.errorOnboardingState());
      },
      (right) {
        if (right) {
          emit(state.visualizedOnboardingState());
        } else {
          emit(state.notVisualizedOnboardingState());
        }
      },
    );
  }

  Future<void> _setOnboardingJumpEvent(
    SetOnboardingJumpEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.loadingOnboardingState());

    final onboardingJump = await _setOnboardingJumpUsecase.call(
      step: event.step,
      onboardingViewKeyEnum: event.onboardingViewKeyEnum,
      additionalParameters: event.additionalParameters,
      analyticsEventEnum: event.analyticsEventEnum,
    );

    onboardingJump.fold(
      (_) {
        emit(state.errorOnboardingState());
      },
      (_) {
        emit(state.visualizedOnboardingState());
      },
    );
  }

  Future<void> _openExternalUrlEvent(
    OpenExternalUrlEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.loadingOnboardingState());

    final openExternalUrl = await _openExternalUrlUsecase.call(
      externalUrl: event.externalUrl,
    );

    openExternalUrl.fold(
      (_) {
        emit(state.errorOnboardingState());
      },
      (_) {},
    );
  }

  Future<void> _nextPageOnboardingEvent(
    NextPageOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    if (event.step > event.maxSteps) {
      emit(state.skipStepOnboardingState());
      return;
    }

    emit(state.loadingOnboardingState());

    final parameters = <String, dynamic>{
      'step': event.step,
    };

    if (event.additionalParameters != null) {
      parameters.addAll(event.additionalParameters!);
    }

    emit(state.goToNextPageState());
  }
}
