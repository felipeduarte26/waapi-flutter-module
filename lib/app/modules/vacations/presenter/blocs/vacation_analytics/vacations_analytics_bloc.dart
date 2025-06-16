import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_vacations_analytics_usecase.dart';
import 'vacations_analytics_event.dart';
import 'vacations_analytics_state.dart';

class VacationsAnalyticsBloc extends Bloc<VacationsAnalyticsEvent, VacationsAnalyticsState> {
  final GetVacationsAnalyticsUsecase _getVacationsAnalyticsUsecase;

  VacationsAnalyticsBloc({
    required GetVacationsAnalyticsUsecase getVacationsAnalyticsUsecase,
  })  : _getVacationsAnalyticsUsecase = getVacationsAnalyticsUsecase,
        super(InitialVacationsAnalyticsState()) {
    on<GetVacationsAnalyticsEvent>(_getVacationsAnalyticsEvent);
  }

  Future<void> _getVacationsAnalyticsEvent(
    GetVacationsAnalyticsEvent event,
    Emitter<VacationsAnalyticsState> emit,
  ) async {
    emit(LoadingVacationsAnalyticsState());

    final vacationsAnalyticsUsecaseResult = await _getVacationsAnalyticsUsecase.call(
      employeeId: event.employeeId,
    );

    vacationsAnalyticsUsecaseResult.fold(
      (_) {
        emit(
          ErrorVacationsAnalyticsState(
            employeeId: event.employeeId,
          ),
        );
      },
      (right) {
        emit(
          LoadedVacationsAnalyticsState(
            vacationsAnalyticsEntity: right,
          ),
        );
      },
    );
  }
}
