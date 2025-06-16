import 'package:equatable/equatable.dart';

abstract class UpdatePersonalDataState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialUpdatePersonalDataState extends UpdatePersonalDataState {}

class LoadingUpdatePersonalDataState extends UpdatePersonalDataState {}

class SentUpdatePersonalDataState extends UpdatePersonalDataState {}

class ErrorUpdatePersonalDataState extends UpdatePersonalDataState {
  final String? errorMessage;

  ErrorUpdatePersonalDataState({
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
