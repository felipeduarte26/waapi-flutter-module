import 'package:equatable/equatable.dart';

import '../../../domain/entities/nationality_entity.dart';

abstract class SearchNationalityState extends Equatable {
  final List<NationalityEntity> nationalityList;
  final NationalityEntity? selectedNationalityEntity;

  const SearchNationalityState({
    this.nationalityList = const [],
    this.selectedNationalityEntity,
  });

  SearchNationalityState initialSearchNationalityState() {
    return InitialSearchNationalityState(
      nationalityEntity: selectedNationalityEntity,
    );
  }

  SearchNationalityState loadingSearchNationalityState() {
    return LoadingSearchNationalityState(
      nationalityEntity: selectedNationalityEntity,
    );
  }

  SearchNationalityState emptyStateSearchNationalityState() {
    return EmptyStateSearchNationalityState(
      nationalityEntity: selectedNationalityEntity,
    );
  }

  SearchNationalityState loadedSearchNationalityState({
    required List<NationalityEntity> nationalityList,
  }) {
    return LoadedSearchNationalityState(
      nationalityList: nationalityList,
      nationalityEntity: selectedNationalityEntity,
    );
  }

  SearchNationalityState errorSearchNationalityState({
    String? message,
    required String search,
  }) {
    return ErrorSearchNationalityState(
      message: message,
      search: search,
      nationalityEntity: selectedNationalityEntity,
    );
  }

  SearchNationalityState loadedSelectNationalityState({
    required NationalityEntity nationalityEntity,
  }) {
    return LoadedSelectNationalityState(
      nationalityEntity: nationalityEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      nationalityList,
      selectedNationalityEntity,
    ];
  }
}

class InitialSearchNationalityState extends SearchNationalityState {
  const InitialSearchNationalityState({
    NationalityEntity? nationalityEntity,
  }) : super(
          nationalityList: const [],
          selectedNationalityEntity: nationalityEntity,
        );
}

class LoadingSearchNationalityState extends SearchNationalityState {
  const LoadingSearchNationalityState({
    NationalityEntity? nationalityEntity,
  }) : super(
          nationalityList: const [],
          selectedNationalityEntity: nationalityEntity,
        );
}

class EmptyStateSearchNationalityState extends SearchNationalityState {
  const EmptyStateSearchNationalityState({
    NationalityEntity? nationalityEntity,
  }) : super(
          nationalityList: const [],
          selectedNationalityEntity: nationalityEntity,
        );
}

class LoadedSearchNationalityState extends SearchNationalityState {
  const LoadedSearchNationalityState({
    required List<NationalityEntity> nationalityList,
    NationalityEntity? nationalityEntity,
  }) : super(
          nationalityList: nationalityList,
          selectedNationalityEntity: nationalityEntity,
        );
}

class LoadingSelectNationalityState extends SearchNationalityState {
  const LoadingSelectNationalityState({
    NationalityEntity? nationalityEntity,
  }) : super(selectedNationalityEntity: nationalityEntity);
}

class LoadedSelectNationalityState extends SearchNationalityState {
  const LoadedSelectNationalityState({
    required NationalityEntity nationalityEntity,
  }) : super(selectedNationalityEntity: nationalityEntity);
}

class ErrorSearchNationalityState extends SearchNationalityState {
  final String? message;
  final String search;

  const ErrorSearchNationalityState({
    required this.message,
    required this.search,
    NationalityEntity? nationalityEntity,
  }) : super(selectedNationalityEntity: nationalityEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
      search,
    ];
  }
}
