import 'package:equatable/equatable.dart';

import '../../enums/vacation_period_situation_enum.dart';
import 'vacation_detail_model.dart';

class VacationsModel extends Equatable {
  final String vacationPeriodId;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? vacationBalance;
  final List<VacationDetailModel>? vacationReceipts;
  final List<VacationDetailModel>? vacationSchedule;
  final VacationPeriodSituationEnum vacationPeriodSituation;
  final List<VacationDetailModel>? vacationWaitingApproval;
  final List<VacationDetailModel>? vacationReturnedToAdjustments;
  final List<VacationDetailModel>? vacationUnderAnalysis;
  final List<VacationDetailModel>? vacationRequestExpired;

  const VacationsModel({
    required this.vacationPeriodId,
    this.startDate,
    this.endDate,
    this.vacationBalance,
    this.vacationReceipts,
    this.vacationSchedule,
    required this.vacationPeriodSituation,
    this.vacationWaitingApproval,
    this.vacationReturnedToAdjustments,
    this.vacationUnderAnalysis,
    this.vacationRequestExpired,
  });

  @override
  List<Object?> get props {
    return [
      vacationPeriodId,
      startDate,
      endDate,
      vacationBalance,
      vacationReceipts,
      vacationSchedule,
      vacationPeriodSituation,
      vacationWaitingApproval,
      vacationReturnedToAdjustments,
      vacationUnderAnalysis,
      vacationRequestExpired,
    ];
  }
}
