import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_payroll_usecase.dart';
import 'payroll_event.dart';
import 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  final GetPayrollUsecase _getPayrollUsecase;

  PayrollBloc({
    required GetPayrollUsecase getPayrollUsecase,
  })  : _getPayrollUsecase = getPayrollUsecase,
        super(const InitialPayrollState()) {
    on<GetPayrollListEvent>(_getPayrollListEvent);
    on<GetPayrollEntityEvent>(_getSelectedPayRoll);
  }

  Future<void> _getPayrollListEvent(
    GetPayrollListEvent event,
    Emitter<PayrollState> emit,
  ) async {
    final bool isAllowedToGetMorePayroll = (state is! LoadingPayrollState &&
            state is! LastPagePayrollState &&
            state is! ErrorPayrollState &&
            state is! LoadingMorePayrollgState) ||
        event.overrideNotAllowedStates;

    if (!isAllowedToGetMorePayroll) {
      return;
    }
    if (state.payroll.isEmpty) {
      emit(state.loadingPayrollState());
    } else {
      emit(state.loadingMorePayrollState());
    }

    final result = await _getPayrollUsecase.call(
      employeeId: event.employeerId,
      paginationRequirements: event.paginationRequirements,
    );

    result.fold(
      (left) {
        emit(
          state.errorPayrollState(
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          if (state.payroll.isEmpty) {
            emit(
              state.emptyListPayrollState(),
            );
          } else {
            emit(
              state.lastPagePayrollState(
                payroll: state.payroll,
              ),
            );
          }
        } else {
          if (state.payroll.length == 1) {
            emit(
              state.loadedPayrollState(
                payroll: right,
              ),
            );
          } else {
            emit(
              state.loadedPayrollState(
                payroll: state.payroll.union(right),
              ),
            );
          }
        }
      },
    );
  }

  Future<void> _getSelectedPayRoll(
    GetPayrollEntityEvent event,
    Emitter<PayrollState> emit,
  ) async {
    emit(state.loadingPayrollState());
    final result = event.payroll;

    emit(
      state.loadedPayrollSelectedState(
        payrollEntitySelected: result,
      ),
    );
  }
}
