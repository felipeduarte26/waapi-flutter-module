import 'package:equatable/equatable.dart';

import '../../../domain/entities/city_entity.dart';

abstract class SearchNaturalityState extends Equatable {
  final List<CityEntity> naturalityList;
  final CityEntity? selectedNaturalityEntity;

  const SearchNaturalityState({
    this.naturalityList = const [],
    this.selectedNaturalityEntity,
  });

  SearchNaturalityState initialSearchNaturalityState() {
    return InitialSearchNaturalityState(
      naturalityEntity: selectedNaturalityEntity,
    );
  }

  SearchNaturalityState loadingSearchNaturalityState() {
    return LoadingSearchNaturalityState(
      naturalityEntity: selectedNaturalityEntity,
    );
  }

  SearchNaturalityState emptyStateSearchNaturalityState() {
    return EmptyStateSearchNaturalityState(
      naturalityEntity: selectedNaturalityEntity,
    );
  }

  SearchNaturalityState loadedSearchNaturalityState({
    required List<CityEntity> naturalityList,
  }) {
    return LoadedSearchNaturalityState(
      naturalityList: naturalityList,
      naturalityEntity: selectedNaturalityEntity,
    );
  }

  SearchNaturalityState errorSearchNaturalityState({
    String? message,
    required String search,
  }) {
    return ErrorSearchNaturalityState(
      message: message,
      search: search,
      naturalityEntity: selectedNaturalityEntity,
    );
  }

  SearchNaturalityState loadedSelectNaturalityState({
    required CityEntity naturalityEntity,
  }) {
    return LoadedSelectNaturalityState(
      naturalityEntity: naturalityEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      naturalityList,
      selectedNaturalityEntity,
    ];
  }
}

class InitialSearchNaturalityState extends SearchNaturalityState {
  const InitialSearchNaturalityState({
    CityEntity? naturalityEntity,
  }) : super(
          naturalityList: const [],
          selectedNaturalityEntity: naturalityEntity,
        );
}

class LoadingSearchNaturalityState extends SearchNaturalityState {
  const LoadingSearchNaturalityState({
    CityEntity? naturalityEntity,
  }) : super(
          naturalityList: const [],
          selectedNaturalityEntity: naturalityEntity,
        );
}

class EmptyStateSearchNaturalityState extends SearchNaturalityState {
  const EmptyStateSearchNaturalityState({
    CityEntity? naturalityEntity,
  }) : super(
          naturalityList: const [],
          selectedNaturalityEntity: naturalityEntity,
        );
}

class LoadedSearchNaturalityState extends SearchNaturalityState {
  const LoadedSearchNaturalityState({
    required List<CityEntity> naturalityList,
    CityEntity? naturalityEntity,
  }) : super(
          naturalityList: naturalityList,
          selectedNaturalityEntity: naturalityEntity,
        );
}

class LoadingSelectNaturalityState extends SearchNaturalityState {
  const LoadingSelectNaturalityState({
    CityEntity? naturalityEntity,
  }) : super(selectedNaturalityEntity: naturalityEntity);
}

class LoadedSelectNaturalityState extends SearchNaturalityState {
  const LoadedSelectNaturalityState({
    required CityEntity naturalityEntity,
  }) : super(selectedNaturalityEntity: naturalityEntity);
}

class ErrorSearchNaturalityState extends SearchNaturalityState {
  final String? message;
  final String search;

  const ErrorSearchNaturalityState({
    required this.message,
    required this.search,
    CityEntity? naturalityEntity,
  }) : super(selectedNaturalityEntity: naturalityEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
      search,
    ];
  }
}
