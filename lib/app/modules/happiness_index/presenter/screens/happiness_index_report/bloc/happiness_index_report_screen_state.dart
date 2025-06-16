import 'package:equatable/equatable.dart';

import '../../../blocs/retrieve_mood_records/retrieve_mood_records_state.dart';

abstract class HappinessIndexReportScreenState extends Equatable {
  final RetrieveMoodRecordsState retrieveMoodRecordsState;

  const HappinessIndexReportScreenState({
    required this.retrieveMoodRecordsState,
  });

  @override
  List<Object> get props => [
        retrieveMoodRecordsState,
      ];
}

class CurrentHappinessIndexReportScreenState extends HappinessIndexReportScreenState {
  const CurrentHappinessIndexReportScreenState({
    required RetrieveMoodRecordsState retrieveMoodRecordsState,
  }) : super(
          retrieveMoodRecordsState: retrieveMoodRecordsState,
        );
}
