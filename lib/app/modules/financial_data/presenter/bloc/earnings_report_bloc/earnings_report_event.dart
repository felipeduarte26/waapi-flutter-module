import 'package:equatable/equatable.dart';

abstract class EarningsReportEvent extends Equatable {}

class GetEarningsReportEvent extends EarningsReportEvent {
  final String registerNumber;
  final int companyNumber;
  final int year;

  GetEarningsReportEvent({
    required this.registerNumber,
    required this.companyNumber,
    required this.year,
  });

  @override
  List<Object> get props {
    return [
      registerNumber,
      companyNumber,
      year,
    ];
  }
}

class ResetEarningsReportEvent extends EarningsReportEvent {
  @override
  List<Object?> get props => [];
}
