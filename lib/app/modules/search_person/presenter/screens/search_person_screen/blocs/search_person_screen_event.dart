import 'package:equatable/equatable.dart';

import '../../../blocs/search_person/search_person_state.dart';

abstract class SearchPersonScreenEvent extends Equatable {}

class ChangeSearchPersonScreenEvent extends SearchPersonScreenEvent {
  final SearchPersonState searchPersonState;

  ChangeSearchPersonScreenEvent({
    required this.searchPersonState,
  });

  @override
  List<Object?> get props {
    return [
      searchPersonState,
    ];
  }
}
