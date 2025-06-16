import 'package:equatable/equatable.dart';

import '../../blocs/happiness_index/happiness_index_state.dart';
import '../../blocs/retrieve_all_reasons/retrieve_all_reasons_state.dart';

abstract class HappinessIndexScreenEvent extends Equatable {}

class ChangeHappinessIndexStateEvent extends HappinessIndexScreenEvent {
  final HappinessIndexState happinessIndexState;

  ChangeHappinessIndexStateEvent({
    required this.happinessIndexState,
  });

  @override
  List<Object?> get props {
    return [
      happinessIndexState,
    ];
  }
}

class ChangeRetrieveAllReasonsStateEvent extends HappinessIndexScreenEvent {
  final RetrieveAllReasonsState retrieveAllReasonsState;

  ChangeRetrieveAllReasonsStateEvent({
    required this.retrieveAllReasonsState,
  });

  @override
  List<Object?> get props {
    return [
      retrieveAllReasonsState,
    ];
  }
}
