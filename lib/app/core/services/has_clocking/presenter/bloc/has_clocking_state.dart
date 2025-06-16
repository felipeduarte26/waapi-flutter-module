// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class HasClockingState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadingClockingState extends HasClockingState {}

class InitialClockingState extends HasClockingState {}

class LoadedClockingState extends HasClockingState {
  final bool hasClocking;

  LoadedClockingState({
    required this.hasClocking,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      hasClocking,
    ];
  }
}
