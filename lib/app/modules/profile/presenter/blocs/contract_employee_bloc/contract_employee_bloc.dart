import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_contract_employee_usecase.dart';
import 'contract_employee_event.dart';
import 'contract_employee_state.dart';

class ContractEmployeeBloc extends Bloc<ContractEmployeeEvent, ContractEmployeeState> {
  final GetContractEmployeeUsecase _getContractEmployeeUsecase;

  ContractEmployeeBloc({
    required GetContractEmployeeUsecase getContractEmployeeUsecase,
  })  : _getContractEmployeeUsecase = getContractEmployeeUsecase,
        super(const InitialContractEmployeeState()) {
    on<GetContractEmployeeEvent>(_getContractEmployeeEvent);
  }

  Future<void> _getContractEmployeeEvent(
    GetContractEmployeeEvent event,
    Emitter<ContractEmployeeState> emit,
  ) async {
    emit(state.loadingContractEmployeeState());

    final contractEmployee = await _getContractEmployeeUsecase.call(
      employeeId: event.employeeId,
    );

    contractEmployee.fold(
      (left) {
        if (state.contractEmployeeEntity != null) {
          emit(state.errorUpdateContractEmployeeState());
          emit(
            state.loadedContractEmployeeState(
              contractEmployeeEntity: state.contractEmployeeEntity!,
            ),
          );
          return;
        }
        emit(state.errorContractEmployeeState());
      },
      (right) {
        emit(
          state.loadedContractEmployeeState(
            contractEmployeeEntity: right,
          ),
        );
      },
    );
  }
}
