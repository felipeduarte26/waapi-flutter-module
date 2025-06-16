import 'package:equatable/equatable.dart';

import '../../../blocs/search_person/search_person_state.dart';

abstract class SearchPersonScreenState extends Equatable {
  final SearchPersonState searchPersonState;

  const SearchPersonScreenState({
    required this.searchPersonState,
  });

  CurrentSearchPersonScreenState currentState({
    SearchPersonState? searchPersonState,
  }) {
    return CurrentSearchPersonScreenState(
      searchPersonState: searchPersonState ?? this.searchPersonState,
    );
  }

  @override
  List<Object?> get props {
    return [
      searchPersonState,
    ];
  }
}

class CurrentSearchPersonScreenState extends SearchPersonScreenState {
  const CurrentSearchPersonScreenState({
    required SearchPersonState searchPersonState,
  }) : super(searchPersonState: searchPersonState);
}
