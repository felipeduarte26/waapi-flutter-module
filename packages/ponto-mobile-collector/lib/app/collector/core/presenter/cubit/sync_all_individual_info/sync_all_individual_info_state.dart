abstract class SyncAllIndividualInfoState {}

class SyncAllIndividualInfoInitialState implements SyncAllIndividualInfoState {}

class SyncAllIndividualInfoInProgressState
    implements SyncAllIndividualInfoState {}

class SyncAllIndividualInfoSuccessState implements SyncAllIndividualInfoState {}

class SyncAllIndividualInfoFailureState implements SyncAllIndividualInfoState {}

class SyncAllIndividualInfoNoConnectionState
    implements SyncAllIndividualInfoState {}

class SyncAllIndividualInfoNotTokenState implements SyncAllIndividualInfoState {}
