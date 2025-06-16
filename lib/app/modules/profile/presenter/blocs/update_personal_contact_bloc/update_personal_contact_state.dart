import 'package:equatable/equatable.dart';

abstract class UpdatePersonalContactState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialUpdatePersonalContactState extends UpdatePersonalContactState {}

class LoadingUpdatePersonalContactState extends UpdatePersonalContactState {}

class SentUpdatePersonalContactState extends UpdatePersonalContactState {}

class ErrorUpdatePersonalContactState extends UpdatePersonalContactState {
  final String? errorMessage;

  ErrorUpdatePersonalContactState({
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
