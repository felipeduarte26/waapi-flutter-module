import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  LoadingOnboardingState loadingOnboardingState() {
    return LoadingOnboardingState();
  }

  GoToNextPageState goToNextPageState() {
    return GoToNextPageState();
  }

  ErrorOnboardingState errorOnboardingState() {
    return ErrorOnboardingState();
  }

  SkipStepOnboardingState skipStepOnboardingState() {
    return SkipStepOnboardingState();
  }

  VisualizedOnboardingState visualizedOnboardingState() {
    return VisualizedOnboardingState();
  }

  NotVisualizedOnboardingState notVisualizedOnboardingState() {
    return NotVisualizedOnboardingState();
  }

  @override
  List<Object?> get props {
    return [];
  }
}

class InitialOnboardingState extends OnboardingState {}

class LoadingOnboardingState extends OnboardingState {}

class GoToNextPageState extends OnboardingState {}

class ErrorOnboardingState extends OnboardingState {}

class SkipStepOnboardingState extends OnboardingState {}

class VisualizedOnboardingState extends OnboardingState {}

class NotVisualizedOnboardingState extends OnboardingState {}
