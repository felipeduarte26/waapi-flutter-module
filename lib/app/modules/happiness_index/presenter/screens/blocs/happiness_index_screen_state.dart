import 'package:equatable/equatable.dart';

import '../../blocs/happiness_index/happiness_index_state.dart';
import '../../blocs/retrieve_all_reasons/retrieve_all_reasons_state.dart';

abstract class HappinessIndexScreenState extends Equatable {
  final HappinessIndexState happinessIndexState;
  final RetrieveAllReasonsState retrieveAllReasonsState;

  const HappinessIndexScreenState({
    required this.happinessIndexState,
    required this.retrieveAllReasonsState,
  });

  CurrentHappinessIndexScreenState currentState({
    HappinessIndexState? happinessIndexState,
    RetrieveAllReasonsState? retrieveAllReasonsState,
  }) {
    return CurrentHappinessIndexScreenState(
      happinessIndexState: happinessIndexState ?? this.happinessIndexState,
      retrieveAllReasonsState: retrieveAllReasonsState ?? this.retrieveAllReasonsState,
    );
  }

  @override
  List<Object> get props => [
        happinessIndexState,
        retrieveAllReasonsState,
      ];
}

class CurrentHappinessIndexScreenState extends HappinessIndexScreenState {
  const CurrentHappinessIndexScreenState({
    required final HappinessIndexState happinessIndexState,
    required final RetrieveAllReasonsState retrieveAllReasonsState,
  }) : super(
          happinessIndexState: happinessIndexState,
          retrieveAllReasonsState: retrieveAllReasonsState,
        );
}
