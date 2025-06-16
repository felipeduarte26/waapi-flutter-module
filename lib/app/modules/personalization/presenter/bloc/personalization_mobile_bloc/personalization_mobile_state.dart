import 'package:equatable/equatable.dart';

import '../../../domain/entities/personalization_mobile_entity.dart';

class PersonalizationMobileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialPersonalizationMobileState extends PersonalizationMobileState {}

class LoadingPersonalizationMobileState extends PersonalizationMobileState {}

class CleanPersonalizationMobileState extends PersonalizationMobileState {}

class LoadedPersonalizationMobileState extends PersonalizationMobileState {
  final PersonalizationMobileEntity personalizationMobileEntity;

  LoadedPersonalizationMobileState({
    required this.personalizationMobileEntity,
  });

  @override
  List<Object> get props {
    return [
      personalizationMobileEntity,
    ];
  }
}

class ErrorPersonalizationMobileState extends PersonalizationMobileState {
  final String? message;
  final PersonalizationMobileEntity? personalizationMobileEntity;

  ErrorPersonalizationMobileState({
    this.message,
    this.personalizationMobileEntity,
  });

  @override
  List<Object?> get props {
    return [
      message,
      personalizationMobileEntity,
    ];
  }
}
