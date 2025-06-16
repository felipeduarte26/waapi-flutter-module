import 'package:equatable/equatable.dart';

import '../../enums/vacation_period_situation_enum.dart';
import 'vacation_detail_entity.dart';

class VacationsEntity extends Equatable {
  final String vacationPeriodId;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? vacationBalance;
  final VacationPeriodSituationEnum vacationPeriodSituation;
  final List<VacationDetailEntity>? vacationReceipts;
  final List<VacationDetailEntity>? vacationSchedule;
  final List<VacationDetailEntity>? vacationWaitingApproval;
  final List<VacationDetailEntity>? vacationReturnedToAdjustments;
  final List<VacationDetailEntity>? vacationUnderAnalysis;
  final List<VacationDetailEntity>? vacationRequestExpired;

  const VacationsEntity({
    required this.vacationPeriodId,
    this.startDate,
    this.endDate,
    this.vacationBalance,
    this.vacationReceipts,
    this.vacationSchedule,
    this.vacationWaitingApproval,
    this.vacationReturnedToAdjustments,
    required this.vacationPeriodSituation,
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
