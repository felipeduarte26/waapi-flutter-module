import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/retrieve_mood_records/retrieve_mood_records_bloc.dart';
import 'happiness_index_report_screen_event.dart';
import 'happiness_index_report_screen_state.dart';

class HappinessIndexReportScreenBloc extends Bloc<HappinessIndexReportScreenEvent, HappinessIndexReportScreenState> {
  final RetrieveMoodRecordsBloc retrieveMoodRecordsBloc;

  late StreamSubscription retrieveMoodRecordsSubscription;

  HappinessIndexReportScreenBloc({
    required this.retrieveMoodRecordsBloc,
  }) : super(
          CurrentHappinessIndexReportScreenState(
            retrieveMoodRecordsState: retrieveMoodRecordsBloc.state,
          ),
        ) {
    on<ChangeRetrieveMoodRecordsStateEvent>(_changeRetrieveMoodRecordsStateEvent);

    retrieveMoodRecordsSubscription = retrieveMoodRecordsBloc.stream.listen(
      (retrieveMoodRecordsState) {
        add(
          ChangeRetrieveMoodRecordsStateEvent(
            retrieveMoodRecordsState: retrieveMoodRecordsState,
          ),
        );
      },
    );
  }

  Future<void> _changeRetrieveMoodRecordsStateEvent(
    ChangeRetrieveMoodRecordsStateEvent event,
    Emitter<HappinessIndexReportScreenState> emit,
  ) async {
    emit(
      CurrentHappinessIndexReportScreenState(
        retrieveMoodRecordsState: event.retrieveMoodRecordsState,
      ),
    );
  }
}
