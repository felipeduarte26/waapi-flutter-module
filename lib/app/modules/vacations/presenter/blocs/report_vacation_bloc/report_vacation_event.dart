// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class ReportVacationEvent extends Equatable {}

class GetReportVacationEvent extends ReportVacationEvent {
  final String reportLink;
  final String reportName;
  final String screenTitle;

  GetReportVacationEvent({
    required this.reportLink,
    required this.reportName,
    required this.screenTitle,
  });

  @override
  List<Object> get props {
    return [
      reportLink,
      reportName,
      screenTitle,
    ];
  }
}

class GetReportNoticeVacationEvent extends ReportVacationEvent {
  final String reportNoticeLink;
  final String reportName;
  final String screenTitle;

  GetReportNoticeVacationEvent({
    required this.reportNoticeLink,
    required this.reportName,
    required this.screenTitle,
  });

  @override
  List<Object> get props {
    return [
      reportNoticeLink,
      reportName,
      screenTitle,
    ];
  }
}
