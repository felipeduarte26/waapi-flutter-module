import 'package:equatable/equatable.dart';

import '../../../domain/entities/city_entity.dart';

abstract class SearchNaturalityEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class SearchNaturalityProfileEvent extends SearchNaturalityEvent {
  final String search;

  SearchNaturalityProfileEvent({
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

class SelectNaturalityFromEntityToProfileEvent extends SearchNaturalityEvent {
  final CityEntity naturalityEntity;

  SelectNaturalityFromEntityToProfileEvent({
    required this.naturalityEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      naturalityEntity,
    ];
  }
}

class UnselectNaturalityProfileEvent extends SearchNaturalityEvent {}

class ClearSearchNaturalityProfileEvent extends SearchNaturalityEvent {}
