import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_employee_company_name_usecase.dart';
import 'company_name_event.dart';
import 'company_name_state.dart';

class CompanyNameBloc extends Bloc<CompanyNameEvent, CompanyNameState> {
  final GetEmployeeCompanyNameUsecase _getCompanyNameUsecase;

  CompanyNameBloc({
    required GetEmployeeCompanyNameUsecase getCompanyNameUsecase,
  })  : _getCompanyNameUsecase = getCompanyNameUsecase,
        super(InitialCompanyNameState()) {
    on<GetCompanyNameEvent>(_getCompanyNameEvent);
  }

  Future<void> _getCompanyNameEvent(
    GetCompanyNameEvent event,
    Emitter<CompanyNameState> emit,
  ) async {
    emit(LoadingCompanyNameState());

    final companyName = await _getCompanyNameUsecase.call(
      employeeId: event.employeeId,
    );

    companyName.fold(
      (left) {
        emit(
          ErrorCompanyNameState(),
        );
      },
      (right) {
        emit(
          LoadedCompanyNameState(
            companyName: right,
          ),
        );
      },
    );
  }
}
