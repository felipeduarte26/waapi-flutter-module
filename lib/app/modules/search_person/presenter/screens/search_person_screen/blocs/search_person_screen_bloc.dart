import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/search_person/search_person_bloc.dart';
import 'search_person_screen_event.dart';
import 'search_person_screen_state.dart';

class SearchPersonScreenBloc extends Bloc<SearchPersonScreenEvent, SearchPersonScreenState> {
  final SearchPersonBloc searchPersonBloc;

  late StreamSubscription searchPersonSubscription;

  SearchPersonScreenBloc({
    required this.searchPersonBloc,
  }) : super(
          CurrentSearchPersonScreenState(
            searchPersonState: searchPersonBloc.state,
          ),
        ) {
    on<ChangeSearchPersonScreenEvent>(_changeSearchPersonScreenEvent);

    searchPersonSubscription = searchPersonBloc.stream.listen(
      (searchPersonState) {
        add(
          ChangeSearchPersonScreenEvent(searchPersonState: searchPersonState),
        );
      },
    );
  }

  Future<void> _changeSearchPersonScreenEvent(
    ChangeSearchPersonScreenEvent event,
    Emitter<SearchPersonScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchPersonState: event.searchPersonState,
      ),
    );
  }

  @override
  Future<void> close() async {
    searchPersonSubscription.cancel();
    super.close();
  }
}
