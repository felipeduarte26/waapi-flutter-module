import 'package:equatable/equatable.dart';

import '../../../domain/entities/country_entity.dart';

abstract class SearchCountryEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class SearchCountryProfileEvent extends SearchCountryEvent {
  final String search;

  SearchCountryProfileEvent({
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

class SelectCountryFromEntityToProfileEvent extends SearchCountryEvent {
  final CountryEntity countryEntity;

  SelectCountryFromEntityToProfileEvent({
    required this.countryEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      countryEntity,
    ];
  }
}

class UnselectCountryProfileEvent extends SearchCountryEvent {}

class ClearSearchCountryProfileEvent extends SearchCountryEvent {}
