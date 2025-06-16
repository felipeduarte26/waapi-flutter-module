import 'package:equatable/equatable.dart';

abstract class GetCurrentVersionState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialGetCurrentVersionState extends GetCurrentVersionState {}

class LoadingGetCurrentVersionState extends GetCurrentVersionState {}

class LoadedGetCurrentVersionState extends GetCurrentVersionState {
  final String version;

  LoadedGetCurrentVersionState({
    required this.version,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      version,
    ];
  }
}

class ErrorGetCurrentVersionState extends GetCurrentVersionState {
  final String? message;

  ErrorGetCurrentVersionState({
    this.message,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}
