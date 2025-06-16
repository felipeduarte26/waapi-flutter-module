import '../../../../core/helper/date_time_helper.dart';
import '../../enums/vacation_detail_type_enum.dart';
import '../../enums/vacation_period_situation_enum.dart';
import '../../infra/models/vacations_model.dart';
import 'vacation_detail_attachments_model_mapper.dart';
import 'vacation_detail_model_mapper.dart';

class VacationsModelMapper {
  static VacationsModel fromMap({
    required Map<String, dynamic> map,
    required VacationPeriodSituationEnum vacationPeriodSituation,
    required Map<String, dynamic> mapSignature,
  }) {
    return VacationsModel(
      endDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['endDate'],
      ),
      startDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['startDate'],
      ),
      vacationPeriodSituation: vacationPeriodSituation,
      vacationPeriodId: map['vacationPeriodId'],
      vacationBalance: map['vacationBalance']?.toDouble(),
      vacationReceipts: map['vacationReceipt'] != null
          ? (map['vacationReceipt'] as List).map(
              (vacationReceipt) {
                return VacationDetailModelMapper.fromMap(
                  map: vacationReceipt,
                  detailType: VacationDetailTypeEnum.receipt,
                  mapSignature: mapSignature,
                );
              },
            ).toList()
          : null,
      vacationSchedule: map['vacationSchedule'] != null
          ? (map['vacationSchedule'] as List).map(
              (vacationSchedule) {
                return VacationDetailModelMapper.fromMap(
                  map: vacationSchedule,
                  detailType: VacationDetailTypeEnum.schedule,
                  mapSignature: mapSignature,
                );
              },
            ).toList()
          : null,
      vacationRequestExpired: map['vacationRequestExpired'] != null
          ? (map['vacationRequestExpired'] as List).map(
              (vacationRequestExpired) {
                return VacationDetailModelMapper.fromMap(
                  map: vacationRequestExpired,
                  detailType: VacationDetailTypeEnum.expiredByLeader,
                  mapSignature: mapSignature,
                );
              },
            ).toList()
          : null,
      vacationWaitingApproval: map['vacationRequest2'] != null
          ? (map['vacationRequest2'] as List).where(
              (element) {
                return element['status'] != 'RETURNED_TO_ADJUSTMENTS' && element['status'] != 'UNDER_ANALYSIS';
              },
            ).map(
              (vacationRequest2) {
                if (vacationRequest2['vacation']['vacationBonusDays'] == '') {
                  vacationRequest2['vacation']['vacationBonusDays'] = 0;
                }
                return VacationDetailModelMapper.fromMap(
                  mapSignature: mapSignature,
                  map: vacationRequest2['vacation'],
                  commentary: vacationRequest2['commentary'],
                  mapAttachments: vacationRequest2['attachments'] != null
                      ? (vacationRequest2['attachments'] as List).map((attachment) {
                          return VacationDetailAttachmentsModelMapper.fromMap(
                            map: attachment,
                          );
                        }).toList()
                      : null,
                  detailType: VacationDetailTypeEnum.waitingApproval,
                );
              },
            ).toList()
          : null,
      vacationUnderAnalysis: map['vacationRequest2'] != null
          ? (map['vacationRequest2'] as List).where(
              (element) {
                return element['status'] == 'UNDER_ANALYSIS';
              },
            ).map(
              (vacationRequest2) {
                if (vacationRequest2['vacation']['vacationBonusDays'] == '') {
                  vacationRequest2['vacation']['vacationBonusDays'] = 0;
                }
                return VacationDetailModelMapper.fromMap(
                  mapSignature: mapSignature,
                  map: vacationRequest2['vacation'],
                  commentary: vacationRequest2['commentary'],
                  mapAttachments: vacationRequest2['attachments'] != null
                      ? (vacationRequest2['attachments'] as List).map((attachment) {
                          return VacationDetailAttachmentsModelMapper.fromMap(
                            map: attachment,
                          );
                        }).toList()
                      : null,
                  detailType: VacationDetailTypeEnum.underAnalysis,
                );
              },
            ).toList()
          : null,
      vacationReturnedToAdjustments: map['vacationRequest2'] != null
          ? (map['vacationRequest2'] as List).where(
              (element) {
                return element['status'] == 'RETURNED_TO_ADJUSTMENTS';
              },
            ).map(
              (vacationRequest2) {
                if (vacationRequest2['vacation']['vacationBonusDays'] == '') {
                  vacationRequest2['vacation']['vacationBonusDays'] = 0;
                }
                var adjustmentMap = vacationRequest2['vacation'];
                return VacationDetailModelMapper.fromMap(
                  mapSignature: mapSignature,
                  approverCommentary: vacationRequest2['approverCommentary'],
                  id: vacationRequest2['vacation']['id'],
                  integrationErrorMessage: vacationRequest2['integrationErrorMessage'],
                  commentary: vacationRequest2['commentary'],
                  mapAttachments: vacationRequest2['attachments'] != null
                      ? (vacationRequest2['attachments'] as List).map((attachment) {
                          return VacationDetailAttachmentsModelMapper.fromMap(
                            map: attachment,
                          );
                        }).toList()
                      : null,
                  map: adjustmentMap,
                  detailType: VacationDetailTypeEnum.returnedToAdjustments,
                );
              },
            ).toList()
          : null,
    );
  }
}
