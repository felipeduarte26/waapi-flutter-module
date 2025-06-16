import 'package:equatable/equatable.dart';

abstract class UpdatePersonalDiversityState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialUpdatePersonalDiversityState extends UpdatePersonalDiversityState {}

class LoadingUpdatePersonalDiversityState extends UpdatePersonalDiversityState {}

class SentUpdatePersonalDiversityState extends UpdatePersonalDiversityState {}

class ErrorUpdatePersonalDiversityState extends UpdatePersonalDiversityState {
  final String? errorMessage;

  ErrorUpdatePersonalDiversityState({
    this.errorMessage,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      errorMessage,
    ];
  }
}
