import '../../domain/entities/vacations_entity.dart';
import '../models/vacations_model.dart';
import 'vacation_detail_entity_adapter.dart';

class VacationsEntityAdapter {
  static VacationsEntity fromModel({
    required VacationsModel vacationsModel,
  }) {
    return VacationsEntity(
      vacationPeriodSituation: vacationsModel.vacationPeriodSituation,
      endDate: vacationsModel.endDate,
      startDate: vacationsModel.startDate,
      vacationBalance: vacationsModel.vacationBalance,
      vacationPeriodId: vacationsModel.vacationPeriodId,
      vacationReceipts: vacationsModel.vacationReceipts?.map(
        (vacationReceiptModel) {
          return VacationDetailEntityAdapter.fromModel(
            vacationDetailModel: vacationReceiptModel,
          );
        },
      ).toList(),
      vacationSchedule: vacationsModel.vacationSchedule?.map(
        (vacationScheduleModel) {
          return VacationDetailEntityAdapter.fromModel(
            vacationDetailModel: vacationScheduleModel,
          );
        },
      ).toList(),
      vacationWaitingApproval: vacationsModel.vacationWaitingApproval?.map(
        (vacationWaitingApproval) {
          return VacationDetailEntityAdapter.fromModel(
            vacationDetailModel: vacationWaitingApproval,
          );
        },
      ).toList(),
      vacationUnderAnalysis: vacationsModel.vacationUnderAnalysis?.map(
        (vacationUnderAnalysis) {
          return VacationDetailEntityAdapter.fromModel(
            vacationDetailModel: vacationUnderAnalysis,
          );
        },
      ).toList(),
      vacationReturnedToAdjustments: vacationsModel.vacationReturnedToAdjustments?.map(
        (vacationReturnedToAdjustments) {
          return VacationDetailEntityAdapter.fromModel(
            vacationDetailModel: vacationReturnedToAdjustments,
          );
        },
      ).toList(),
      vacationRequestExpired: vacationsModel.vacationRequestExpired?.map(
        (vacationRequestExpired) {
          return VacationDetailEntityAdapter.fromModel(
            vacationDetailModel: vacationRequestExpired,
          );
        },
      ).toList(),
    );
  }
}
