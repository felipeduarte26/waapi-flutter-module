part of 'search_ethnicity_bloc.dart';

sealed class SearchEthnicityState extends Equatable {
  final List<EthnicityEntity> ethnicityList;
  final EthnicityEntity? selectedEthnicityEntity;

  const SearchEthnicityState({
    this.ethnicityList = const [],
    this.selectedEthnicityEntity,
  });

  SearchEthnicityState initialSearchEthnicityState() {
    return InitialSearchEthnicityState(
      ethnicityEntity: selectedEthnicityEntity,
    );
  }

  SearchEthnicityState loadingSearchEthnicityState() {
    return LoadingSearchEthnicityState(
      ethnicityEntity: selectedEthnicityEntity,
    );
  }

  SearchEthnicityState emptySearchEthnicityState() {
    return EmptySearchEthnicityState(
      ethnicityEntity: selectedEthnicityEntity,
    );
  }

  SearchEthnicityState loadedSearchEthnicityState({
    required List<EthnicityEntity> ethnicityList,
  }) {
    return LoadedSearchEthnicityState(
      ethnicityList: ethnicityList,
      ethnicityEntity: selectedEthnicityEntity,
    );
  }

  SearchEthnicityState errorSearchEthnicityState({
    String? message,
    required String search,
  }) {
    return ErrorSearchEthnicityState(
      message: message,
      search: search,
      ethnicityEntity: selectedEthnicityEntity,
    );
  }

  SearchEthnicityState loadingSelectedEthnicityState() {
    return LoadingSelectedEthnicityState(
      ethnicityEntity: selectedEthnicityEntity,
    );
  }

  SearchEthnicityState loadedSelectedEthnicityState({
    required EthnicityEntity ethnicityEntity,
  }) {
    return LoadedSelectedEthnicityState(
      ethnicityEntity: ethnicityEntity,
    );
  }

  @override
  List<Object?> get props => [];
}

class InitialSearchEthnicityState extends SearchEthnicityState {
  const InitialSearchEthnicityState({
    EthnicityEntity? ethnicityEntity,
  }) : super(
          ethnicityList: const [],
          selectedEthnicityEntity: ethnicityEntity,
        );
}

class LoadingSearchEthnicityState extends SearchEthnicityState {
  const LoadingSearchEthnicityState({
    EthnicityEntity? ethnicityEntity,
  }) : super(
          ethnicityList: const [],
          selectedEthnicityEntity: ethnicityEntity,
        );
}

class EmptySearchEthnicityState extends SearchEthnicityState {
  const EmptySearchEthnicityState({
    EthnicityEntity? ethnicityEntity,
  }) : super(
          ethnicityList: const [],
          selectedEthnicityEntity: ethnicityEntity,
        );
}

class LoadedSearchEthnicityState extends SearchEthnicityState {
  const LoadedSearchEthnicityState({
    required List<EthnicityEntity> ethnicityList,
    EthnicityEntity? ethnicityEntity,
  }) : super(
          ethnicityList: ethnicityList,
          selectedEthnicityEntity: ethnicityEntity,
        );
}

class LoadingSelectedEthnicityState extends SearchEthnicityState {
  const LoadingSelectedEthnicityState({
    EthnicityEntity? ethnicityEntity,
  }) : super(
          selectedEthnicityEntity: ethnicityEntity,
        );
}

class LoadedSelectedEthnicityState extends SearchEthnicityState {
  const LoadedSelectedEthnicityState({
    EthnicityEntity? ethnicityEntity,
  }) : super(
          selectedEthnicityEntity: ethnicityEntity,
        );
}

class ErrorSearchEthnicityState extends SearchEthnicityState {
  final String? message;
  final String search;

  const ErrorSearchEthnicityState({
    required this.message,
    required this.search,
    EthnicityEntity? ethnicityEntity,
  }) : super(selectedEthnicityEntity: ethnicityEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
      search,
    ];
  }
}
