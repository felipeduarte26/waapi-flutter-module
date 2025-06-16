import 'package:equatable/equatable.dart';

abstract class G5ConnectorState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadingG5ConnectorState extends G5ConnectorState {}

class InitialG5ConnectorState extends G5ConnectorState {}

class LoadedG5ConnectorState extends G5ConnectorState {
  final String connector;

  LoadedG5ConnectorState({
    required this.connector,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      connector,
    ];
  }
}

class ErrorG5ConnectorState extends G5ConnectorState {}
