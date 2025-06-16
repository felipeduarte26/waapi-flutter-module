part of 'personalization_bloc.dart';

abstract class PersonalizationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPersonalizationEvent extends PersonalizationEvent {}

class ReloadPersonalizationEvent extends PersonalizationEvent {}
