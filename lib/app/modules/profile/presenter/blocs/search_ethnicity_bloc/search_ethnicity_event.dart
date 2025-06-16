part of 'search_ethnicity_bloc.dart';

sealed class SearchEthnicityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchEthnicityProfileEvent extends SearchEthnicityEvent {
  final String search;

  SearchEthnicityProfileEvent({
    required this.search,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      search,
    ];
  }
}

class SelectEthnicityFromEntityToProfileEvent extends SearchEthnicityEvent {
  final EthnicityEntity ethnicityEntity;

  SelectEthnicityFromEntityToProfileEvent({
    required this.ethnicityEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      ethnicityEntity,
    ];
  }
}

class UnselectEthnicityProfileEvent extends SearchEthnicityEvent {}

class ClearSearchEthnicityProfileEvent extends SearchEthnicityEvent {}
