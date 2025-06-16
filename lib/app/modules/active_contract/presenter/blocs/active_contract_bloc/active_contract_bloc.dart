import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/failures/active_contract_failure.dart';
import '../../../domain/usecases/get_active_contract_usecase.dart';
import 'active_contract_event.dart';
import 'active_contract_state.dart';

class ActiveContractBloc extends Bloc<ActiveContractEvent, ActiveContractState> {
  final GetActiveContractUsecase _getActiveContractUsecase;

  ActiveContractBloc({
    required GetActiveContractUsecase getActiveContractUsecase,
  })  : _getActiveContractUsecase = getActiveContractUsecase,
        super(InitialActiveContractState()) {
    on<GetActiveContractEvent>(_getActiveContractEvent);
  }

  Future<void> _getActiveContractEvent(
    GetActiveContractEvent _,
    Emitter<ActiveContractState> emit,
  ) async {
    emit(LoadingActiveContractState());

    final activeContract = await _getActiveContractUsecase.call();

    activeContract.fold(
      (left) {
        if (left is NoActiveContractFoundFailure) {
          emit(NoActiveContractState());
        } else {
          emit(ErrorActiveContractState());
        }
      },
      (right) {
        emit(
          LoadedActiveContractState(
            activeContractEntity: right,
          ),
        );
      },
    );
  }
}
