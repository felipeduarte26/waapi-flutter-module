import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../personalization/presenter/bloc/personalization_bloc/personalization_bloc.dart';
import '../../../../../profile/presenter/blocs/contract_employee_bloc/contract_employee_bloc.dart';
import '../../../../../profile/presenter/blocs/contract_employee_bloc/contract_employee_state.dart';
import '../../../../../profile/presenter/blocs/profile_bloc/profile_bloc.dart';
import '../../../../../profile/presenter/blocs/profile_bloc/profile_state.dart';
import '../../../bloc/payroll_bloc/payroll_bloc.dart';
import '../../../bloc/payroll_bloc/payroll_state.dart';

part 'payroll_screen_event.dart';
part 'payroll_screen_state.dart';

class PayrollScreenBloc extends Bloc<PayrollScreenEvent, PayrollScreenState> {
  late final PayrollBloc payrollBloc;
  final PersonalizationBloc personalizationBloc;
  final ProfileBloc profileBloc;
  final ContractEmployeeBloc contractEmployeeBloc;

  late StreamSubscription payrollSubscription;
  late StreamSubscription personalizationSubscription;
  late StreamSubscription profileSubscription;
  late StreamSubscription contractEmployeeSubscription;

  PayrollScreenBloc({
    required this.payrollBloc,
    required this.personalizationBloc,
    required this.profileBloc,
    required this.contractEmployeeBloc,
  }) : super(
          CurrentPayrollScreenState(
            payrollState: payrollBloc.state,
            personalizationState: personalizationBloc.state,
            profileState: profileBloc.state,
            contractEmployeeState: contractEmployeeBloc.state,
          ),
        ) {
    on<ChangePayrollStateEvent>(_changePayrollStateEvent);
    on<ChangePersonalizationStateEvent>(_changePersonalizationStateEvent);
    on<ChangeProfileStateEvent>(_changeProfileStateEvent);
    on<ChangeContractEmployeeStateEvent>(_changeContractEmployeeStateEvent);

    payrollSubscription = payrollBloc.stream.listen(
      (payrollState) {
        add(
          ChangePayrollStateEvent(
            payrollState: payrollState,
          ),
        );
      },
    );

    personalizationSubscription = personalizationBloc.stream.listen(
      (personalizationState) {
        add(
          ChangePersonalizationStateEvent(
            personalizationState: personalizationState,
          ),
        );
      },
    );

    profileSubscription = profileBloc.stream.listen(
      (profileState) {
        add(
          ChangeProfileStateEvent(
            profileState: profileState,
          ),
        );
      },
    );

    contractEmployeeSubscription = contractEmployeeBloc.stream.listen(
      (contractEmployeeState) {
        add(
          ChangeContractEmployeeStateEvent(
            contractEmployeeState: contractEmployeeState,
          ),
        );
      },
    );
  }

  Future<void> _changePayrollStateEvent(
    ChangePayrollStateEvent event,
    Emitter<PayrollScreenState> emit,
  ) async {
    emit(
      state.currentState(
        payrollState: event.payrollState,
      ),
    );
  }

  Future<void> _changePersonalizationStateEvent(
    ChangePersonalizationStateEvent event,
    Emitter<PayrollScreenState> emit,
  ) async {
    emit(
      state.currentState(
        personalizationState: event.personalizationState,
      ),
    );
  }

  Future<void> _changeProfileStateEvent(
    ChangeProfileStateEvent event,
    Emitter<PayrollScreenState> emit,
  ) async {
    emit(
      state.currentState(
        profileState: event.profileState,
      ),
    );
  }

  Future<void> _changeContractEmployeeStateEvent(
    ChangeContractEmployeeStateEvent event,
    Emitter<PayrollScreenState> emit,
  ) async {
    emit(
      state.currentState(
        contractEmployeeState: event.contractEmployeeState,
      ),
    );
  }
}
