import 'package:equatable/equatable.dart';

import '../../../domain/entities/country_entity.dart';

abstract class SearchCountryState extends Equatable {
  final List<CountryEntity> countryList;
  final CountryEntity? selectedCountryEntity;

  const SearchCountryState({
    this.countryList = const [],
    this.selectedCountryEntity,
  });

  SearchCountryState initialSearchCountryState() {
    return InitialSearchCountryState(
      countryEntity: selectedCountryEntity,
    );
  }

  SearchCountryState loadingSearchCountryState() {
    return LoadingSearchCountryState(
      countryEntity: selectedCountryEntity,
    );
  }

  SearchCountryState emptyStateSearchCountryState() {
    return EmptyStateSearchCountryState(
      countryEntity: selectedCountryEntity,
    );
  }

  SearchCountryState loadedSearchCountryState({
    required List<CountryEntity> countryList,
  }) {
    return LoadedSearchCountryState(
      countryList: countryList,
      countryEntity: selectedCountryEntity,
    );
  }

  SearchCountryState errorSearchCountryState({
    String? message,
    required String search,
  }) {
    return ErrorSearchCountryState(
      message: message,
      search: search,
      countryEntity: selectedCountryEntity,
    );
  }

  SearchCountryState loadedSelectCountryState({
    required CountryEntity countryEntity,
  }) {
    return LoadedSelectCountryState(
      countryEntity: countryEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      countryList,
      selectedCountryEntity,
    ];
  }
}

class InitialSearchCountryState extends SearchCountryState {
  const InitialSearchCountryState({
    CountryEntity? countryEntity,
  }) : super(
          countryList: const [],
          selectedCountryEntity: countryEntity,
        );
}

class LoadingSearchCountryState extends SearchCountryState {
  const LoadingSearchCountryState({
    CountryEntity? countryEntity,
  }) : super(
          countryList: const [],
          selectedCountryEntity: countryEntity,
        );
}

class EmptyStateSearchCountryState extends SearchCountryState {
  const EmptyStateSearchCountryState({
    CountryEntity? countryEntity,
  }) : super(
          countryList: const [],
          selectedCountryEntity: countryEntity,
        );
}

class LoadedSearchCountryState extends SearchCountryState {
  const LoadedSearchCountryState({
    required List<CountryEntity> countryList,
    CountryEntity? countryEntity,
  }) : super(
          countryList: countryList,
          selectedCountryEntity: countryEntity,
        );
}

class LoadingSelectCountryState extends SearchCountryState {
  const LoadingSelectCountryState({
    CountryEntity? countryEntity,
  }) : super(selectedCountryEntity: countryEntity);
}

class LoadedSelectCountryState extends SearchCountryState {
  const LoadedSelectCountryState({
    required CountryEntity countryEntity,
  }) : super(selectedCountryEntity: countryEntity);
}

class ErrorSearchCountryState extends SearchCountryState {
  final String? message;
  final String search;

  const ErrorSearchCountryState({
    required this.message,
    required this.search,
    CountryEntity? countryEntity,
  }) : super(selectedCountryEntity: countryEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
      search,
    ];
  }
}
