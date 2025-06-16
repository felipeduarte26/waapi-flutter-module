// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class ReportVacationState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadedReportVacationState extends ReportVacationState {
  final List<int> reportVacation;
  final String reportName;
  final String screenTitle;

  LoadedReportVacationState({
    required this.reportVacation,
    required this.reportName,
    required this.screenTitle,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      reportVacation,
      reportName,
      screenTitle,
    ];
  }
}

class ErrorReportVacationState extends ReportVacationState {}

class LoadingReportVacationState extends ReportVacationState {}

class LoadingReportNoticeVacationState extends ReportVacationState {}

class InitialReportVacationState extends ReportVacationState {}
