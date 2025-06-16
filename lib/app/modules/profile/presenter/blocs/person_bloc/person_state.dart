import 'package:equatable/equatable.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialPersonState extends PersonState {}

class LoadingPersonState extends PersonState {}

class LoadedPersonState extends PersonState {
  final String personId;

  const LoadedPersonState({
    required this.personId,
  });
}

class ErrorPersonState extends PersonState {}
