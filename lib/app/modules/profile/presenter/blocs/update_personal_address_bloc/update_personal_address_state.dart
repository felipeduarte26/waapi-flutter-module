import 'package:equatable/equatable.dart';

abstract class UpdatePersonalAddressState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialUpdatePersonalAddressState extends UpdatePersonalAddressState {}

class LoadingUpdatePersonalAddressState extends UpdatePersonalAddressState {}

class SentUpdatePersonalAddressState extends UpdatePersonalAddressState {}

class ErrorUpdatePersonalAddressState extends UpdatePersonalAddressState {
  final String? errorMessage;

  ErrorUpdatePersonalAddressState({
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
