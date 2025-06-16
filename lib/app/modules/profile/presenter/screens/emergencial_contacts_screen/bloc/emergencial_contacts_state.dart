import 'package:equatable/equatable.dart';

abstract class EmergencialContactsState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialEmergencialContactsState extends EmergencialContactsState {}

class LoadingEmergencialContactsState extends EmergencialContactsState {}

class LoadedEmergencialContactsState extends EmergencialContactsState {}

class DeletionEmergencialContactsState extends EmergencialContactsState {}

class DeletingEmergencialContactsState extends EmergencialContactsState {}

class ErrorEmergencialContactsState extends EmergencialContactsState {
  final String? emergencialContactResult;

  ErrorEmergencialContactsState({
    required this.emergencialContactResult,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      emergencialContactResult,
    ];
  }
}

class SendDeletionErrorEmergencialContactsState extends EmergencialContactsState {
  final String? emergencialContactResult;

  SendDeletionErrorEmergencialContactsState({
    required this.emergencialContactResult,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      emergencialContactResult,
    ];
  }
}
