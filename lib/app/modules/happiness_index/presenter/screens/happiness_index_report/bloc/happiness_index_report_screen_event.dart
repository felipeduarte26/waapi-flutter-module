import 'package:equatable/equatable.dart';

import '../../../blocs/retrieve_mood_records/retrieve_mood_records_state.dart';

abstract class HappinessIndexReportScreenEvent extends Equatable {}

class ChangeRetrieveMoodRecordsStateEvent extends HappinessIndexReportScreenEvent {
  final RetrieveMoodRecordsState retrieveMoodRecordsState;

  ChangeRetrieveMoodRecordsStateEvent({
    required this.retrieveMoodRecordsState,
  });

  @override
  List<Object?> get props => [
        retrieveMoodRecordsState,
      ];
}
