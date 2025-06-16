import 'package:equatable/equatable.dart';

import '../../../domain/entities/person_entity.dart';

abstract class SearchPersonState extends Equatable {
  final List<PersonEntity> personEntityList;
  final String searchTerm;

  const SearchPersonState({
    this.personEntityList = const <PersonEntity>[],
    this.searchTerm = '',
  });

  LoadingSearchPersonState loadingSearchPersonState({
    required String searchTerm,
  }) {
    return LoadingSearchPersonState(
      searchTerm: searchTerm,
    );
  }

  LoadedSearchPersonState loadedSearchPersonState({
    required List<PersonEntity> personEntityList,
    required String searchTerm,
  }) {
    return LoadedSearchPersonState(
      personEntityList: personEntityList,
      searchTerm: searchTerm,
    );
  }

  LastPageSearchPersonState lastPageSearchPersonState({
    required List<PersonEntity> personEntityList,
    required String searchTerm,
  }) {
    return LastPageSearchPersonState(
      personEntityList: personEntityList,
      searchTerm: searchTerm,
    );
  }

  EmptySearchPersonState emptySearchPersonState({
    required String searchTerm,
  }) {
    return EmptySearchPersonState(
      searchTerm: searchTerm,
    );
  }

  ErrorSearchPersonState errorSearchPersonState({
    required String searchTerm,
  }) {
    return ErrorSearchPersonState(
      searchTerm: searchTerm,
    );
  }

  LoadingMoreSearchPersonState loadingMoreSearchPersonState({
    required List<PersonEntity> personEntityList,
    required String searchTerm,
  }) {
    return LoadingMoreSearchPersonState(
      personEntityList: personEntityList,
      searchTerm: searchTerm,
    );
  }

  ErrorMoreSearchPersonState errorMoreSearchPersonState({
    required List<PersonEntity> personEntityList,
    required String searchTerm,
  }) {
    return ErrorMoreSearchPersonState(
      personEntityList: personEntityList,
      searchTerm: searchTerm,
    );
  }

  CleanSearchPersonState cleanSearchPersonState() {
    return const CleanSearchPersonState();
  }

  @override
  List<Object?> get props {
    return [];
  }
}

class InitialSearchPersonState extends SearchPersonState {
  const InitialSearchPersonState() : super();
}

class LoadingSearchPersonState extends SearchPersonState {
  const LoadingSearchPersonState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class LoadingMoreSearchPersonState extends SearchPersonState {
  const LoadingMoreSearchPersonState({
    required List<PersonEntity> personEntityList,
    required String searchTerm,
  }) : super(
          personEntityList: personEntityList,
          searchTerm: searchTerm,
        );
}

class LoadedSearchPersonState extends SearchPersonState {
  const LoadedSearchPersonState({
    required List<PersonEntity> personEntityList,
    required String searchTerm,
  }) : super(
          personEntityList: personEntityList,
          searchTerm: searchTerm,
        );
}

class LastPageSearchPersonState extends SearchPersonState {
  const LastPageSearchPersonState({
    required List<PersonEntity> personEntityList,
    required String searchTerm,
  }) : super(
          personEntityList: personEntityList,
          searchTerm: searchTerm,
        );
}

class EmptySearchPersonState extends SearchPersonState {
  const EmptySearchPersonState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class ErrorSearchPersonState extends SearchPersonState {
  const ErrorSearchPersonState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class ErrorMoreSearchPersonState extends SearchPersonState {
  const ErrorMoreSearchPersonState({
    required List<PersonEntity> personEntityList,
    required String searchTerm,
  }) : super(
          personEntityList: personEntityList,
          searchTerm: searchTerm,
        );
}

class CleanSearchPersonState extends SearchPersonState {
  const CleanSearchPersonState() : super();
}
