import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/enums/sync_individual_status_type.dart';
import '../../../domain/usecases/sync_all_individual_info_usecase.dart';
import 'sync_all_individual_info_state.dart';

/// Cubit used to indicate synchronization of all Individual/Driver mode information
class SyncAllIndividualInfoCubit extends Cubit<SyncAllIndividualInfoState> {
  final SyncAllIndividualInfoUsecase _syncAllIndividualInfoUsecase;

  Future<SyncIndividualStatusType>? futureCall;
  SyncAllIndividualInfoCubit({
    required SyncAllIndividualInfoUsecase syncAllIndividualInfoUsecase,
  })  : _syncAllIndividualInfoUsecase = syncAllIndividualInfoUsecase,
        super(SyncAllIndividualInfoInitialState()) {
    if (futureCall != null) {
      emit(SyncAllIndividualInfoInProgressState());
    }
  }

  Future<void> syncAllIndividualInfo() async {
    emit(SyncAllIndividualInfoInProgressState());

    futureCall = _syncAllIndividualInfoUsecase
        .call()
        .whenComplete(() => futureCall = null);

    SyncIndividualStatusType syncMultipleStatusType = await futureCall!;

    switch (syncMultipleStatusType) {
      case SyncIndividualStatusType.tokenUnavailable:
        emit(SyncAllIndividualInfoNotTokenState());
        break;
      case SyncIndividualStatusType.connectionUnavailable:
        emit(SyncAllIndividualInfoNoConnectionState());
        break;
      case SyncIndividualStatusType.success:
        emit(SyncAllIndividualInfoSuccessState());
        break;
      case SyncIndividualStatusType.failure:
        emit(SyncAllIndividualInfoFailureState());
        break;
    }
  }
}
