import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import 'onboarding_screen_event.dart';
import 'onboarding_screen_state.dart';

class OnboardingScreenBloc extends Bloc<OnboardingScreenEvent, OnboardingScreenState> {
  final OnboardingBloc onboardingBloc;

  late StreamSubscription onboardingSubscription;

  OnboardingScreenBloc({
    required this.onboardingBloc,
  }) : super(
          CurrentOnboardingScreenState(
            onboardingState: onboardingBloc.state,
          ),
        ) {
    on<ChangeOnboardingScreenEvent>(
      _changeOnboardingScreenEvent,
    );

    onboardingSubscription = onboardingBloc.stream.listen(
      (onboardingStatus) {
        add(
          ChangeOnboardingScreenEvent(
            onboardingState: onboardingStatus,
          ),
        );
      },
    );
  }

  Future<void> _changeOnboardingScreenEvent(
    ChangeOnboardingScreenEvent event,
    Emitter<OnboardingScreenState> emit,
  ) async {
    emit(
      state.currentState(
        onboardingState: event.onboardingState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await onboardingSubscription.cancel();
    return super.close();
  }
}
