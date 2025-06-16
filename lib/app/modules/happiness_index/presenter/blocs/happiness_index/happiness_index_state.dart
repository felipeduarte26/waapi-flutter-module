import 'package:equatable/equatable.dart';

import '../../../domain/entities/happiness_index_mood_entity.dart';

abstract class HappinessIndexState extends Equatable {
  const HappinessIndexState();

  @override
  List<Object> get props {
    return [];
  }
}

class EmptyHappinessIndexState extends HappinessIndexState {}

class ErrorOnGetHappinessIndexState extends HappinessIndexState {
  final String? message;

  const ErrorOnGetHappinessIndexState({
    required this.message,
  });
}

class LoadingHappinessIndexState extends HappinessIndexState {}

class LoadedHappinessIndexState extends HappinessIndexState {
  final HappinessIndexMoodEntity happinessIndexMood;

  const LoadedHappinessIndexState({
    required this.happinessIndexMood,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      happinessIndexMood,
    ];
  }
}

class SuccessOnSaveHappinessIndexState extends HappinessIndexState {}

class ErrorOnSaveHappinessIndexState extends HappinessIndexState {
  final String? message;

  const ErrorOnSaveHappinessIndexState({
    required this.message,
  });
}

class HappinessIndexIsEnabledState extends HappinessIndexState {}

class HappinessIndexIsNotEnabledState extends HappinessIndexState {}
