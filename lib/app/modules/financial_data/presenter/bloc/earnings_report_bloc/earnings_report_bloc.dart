import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_earnings_reports_usecase.dart';
import 'earnings_report_event.dart';
import 'earnings_report_state.dart';

class EarningsReportBloc extends Bloc<EarningsReportEvent, EarningsReportState> {
  final GetEarningsReportsUsecase _getEarningsReportsUsecase;

  EarningsReportBloc({
    required GetEarningsReportsUsecase getEarningsReportsUsecase,
  })  : _getEarningsReportsUsecase = getEarningsReportsUsecase,
        super(InitialEarningsReportState()) {
    on<GetEarningsReportEvent>(_getEarningsReportEvent);
    on<ResetEarningsReportEvent>(_resetEarningsReportEvent);
  }

  Future<void> _getEarningsReportEvent(
    GetEarningsReportEvent event,
    Emitter<EarningsReportState> emit,
  ) async {
    emit(LoadingEarningsReportState());

    final links = await _getEarningsReportsUsecase.call(
      companyNumber: event.companyNumber,
      registerNumber: event.registerNumber,
      year: event.year,
    );

    links.fold(
      (left) {
        emit(
          ErrorEarningsReportState(),
        );
      },
      (right) {
        emit(
          LoadedEarningsReportState(
            pdf: right,
          ),
        );
      },
    );
  }

  Future<void> _resetEarningsReportEvent(
    ResetEarningsReportEvent _,
    Emitter<EarningsReportState> emit,
  ) async {
    emit(
      InitialEarningsReportState(),
    );
  }
}
