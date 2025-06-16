import 'package:equatable/equatable.dart';

abstract class UpdatePersonalDocumentsState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialUpdatePersonalDocumentsState extends UpdatePersonalDocumentsState {}

class LoadingUpdatePersonalDocumentsState extends UpdatePersonalDocumentsState {}

class SentUpdatePersonalDocumentsState extends UpdatePersonalDocumentsState {}

class ErrorUpdatePersonalDocumentsState extends UpdatePersonalDocumentsState {
  final String? errorMessage;

  ErrorUpdatePersonalDocumentsState({
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
