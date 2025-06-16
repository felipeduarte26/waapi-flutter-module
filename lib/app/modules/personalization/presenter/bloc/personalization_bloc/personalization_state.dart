part of 'personalization_bloc.dart';

abstract class PersonalizationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialPersonalizationState extends PersonalizationState {}

class LoadingPersonalizationState extends PersonalizationState {}

class LoadedPersonalizationState extends PersonalizationState {
  final PersonalizationEntity personalizationEntity;

  LoadedPersonalizationState({
    required this.personalizationEntity,
  });

  @override
  List<Object> get props {
    return [
      personalizationEntity,
    ];
  }
}

class ErrorPersonalizationState extends PersonalizationState {
  final String? message;

  ErrorPersonalizationState({
    this.message,
  });

  @override
  List<Object?> get props {
    return [
      message,
    ];
  }
}
