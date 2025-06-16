import 'package:equatable/equatable.dart';

abstract class IAAssistState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadingIAAssistState extends IAAssistState {}

class InitialIAAssistState extends IAAssistState {}

class LoadedIAAssistState extends IAAssistState {
  final String text;

  LoadedIAAssistState({
    required this.text,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      text,
    ];
  }
}

class ErrorIAAssistState extends IAAssistState {}
