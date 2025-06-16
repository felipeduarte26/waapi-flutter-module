import 'package:equatable/equatable.dart';

abstract class EarningsReportState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadingEarningsReportState extends EarningsReportState {}

class InitialEarningsReportState extends EarningsReportState {}

class LoadedEarningsReportState extends EarningsReportState {
  final List<int> pdf;

  LoadedEarningsReportState({
    required this.pdf,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      pdf,
    ];
  }
}

class ErrorEarningsReportState extends EarningsReportState {}
