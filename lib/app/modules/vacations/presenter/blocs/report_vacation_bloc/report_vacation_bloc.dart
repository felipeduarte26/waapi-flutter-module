import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_report_vacation_usecase.dart';
import 'report_vacation_event.dart';
import 'report_vacation_state.dart';

class ReportVacationBloc extends Bloc<ReportVacationEvent, ReportVacationState> {
  final GetReportVacationUsecase _getReportVacationUsecase;

  ReportVacationBloc({
    required GetReportVacationUsecase getReportVacationUsecase,
  })  : _getReportVacationUsecase = getReportVacationUsecase,
        super(InitialReportVacationState()) {
    on<GetReportVacationEvent>(_getReportVacationEvent);
    on<GetReportNoticeVacationEvent>(_getReportNoticeVacationEvent);
  }

  Future<void> _getReportVacationEvent(
    GetReportVacationEvent event,
    Emitter<ReportVacationState> emit,
  ) async {
    emit(LoadingReportVacationState());

    final reportVacationUsecaseResult = await _getReportVacationUsecase.call(
      reportLink: event.reportLink,
    );

    reportVacationUsecaseResult.fold(
      (_) {
        emit(
          ErrorReportVacationState(),
        );
      },
      (right) {
        emit(
          LoadedReportVacationState(
            reportVacation: right,
            reportName: event.reportName,
            screenTitle: event.screenTitle,
          ),
        );
      },
    );
  }

  Future<void> _getReportNoticeVacationEvent(
    GetReportNoticeVacationEvent event,
    Emitter<ReportVacationState> emit,
  ) async {
    emit(LoadingReportNoticeVacationState());

    final reportVacationUsecaseResult = await _getReportVacationUsecase.call(
      reportLink: event.reportNoticeLink,
    );

    reportVacationUsecaseResult.fold(
      (_) {
        emit(
          ErrorReportVacationState(),
        );
      },
      (right) {
        emit(
          LoadedReportVacationState(
            reportVacation: right,
            reportName: event.reportName,
            screenTitle: event.screenTitle,
          ),
        );
      },
    );
  }
}
