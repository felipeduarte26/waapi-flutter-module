import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/locale_helper.dart';
import '../../../../core/helper/string_helper.dart';
import '../../../../core/widgets/document_item_widget.dart';
import '../../../../core/widgets/waapi_card_widget.dart';
import '../../domain/entities/vacation_detail_entity.dart';
import '../../enums/vacation_detail_type_enum.dart';
import '../../enums/vacation_document_status_enum.dart';
import '../../enums/vacation_situation_type_enum.dart';
import '../../enums/vacation_type_enum.dart';
import '../string_formatters/vacation_situation_type_formatter.dart';
import '../string_formatters/vacation_type_formatter.dart';

class VacationScheduleCardWidget extends StatelessWidget {
  final VacationDetailEntity vacationScheduleEntity;
  final bool showActionIcon;
  final VoidCallback? onTap;
  final bool showNote;
  final bool isRequestVacationUpdate;
  final bool canShowSignatureAlert;

  const VacationScheduleCardWidget({
    Key? key,
    required this.vacationScheduleEntity,
    this.showActionIcon = false,
    this.onTap,
    this.showNote = true,
    this.isRequestVacationUpdate = false,
    this.canShowSignatureAlert = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasSignature = (vacationScheduleEntity.vacationNoticeSignatureData != null &&
            vacationScheduleEntity.vacationNoticeSignatureData!.status == VacationDocumentStatusEnum.inSignature) ||
        (vacationScheduleEntity.vacationReceiptSignatureData != null &&
            vacationScheduleEntity.vacationReceiptSignatureData!.status == VacationDocumentStatusEnum.inSignature);

    return WaapiCardWidget(
      onTap: onTap,
      key: const Key('vacation-vacation_schedule_card-card'),
      showActionIcon: showActionIcon,
      margin: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      child: Row(
        children: [
          vacationScheduleEntity.detailType == VacationDetailTypeEnum.receipt
              ? const Padding(
                  padding: EdgeInsets.only(
                    left: SeniorSpacing.xxsmall,
                    right: SeniorSpacing.small,
                  ),
                  child: SeniorIcon(
                    icon: FontAwesomeIcons.solidPlane,
                    size: SeniorSpacing.medium,
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SeniorBadge.icon(
                  shape: SeniorBadgeShape.chip,
                  backgroundColor: _getColorBackgroundBadge(),
                  fontColor: _getColorFontBadge(),
                  icon: _getIconBadge(),
                  label: VacationSituationTypeFormatter.getVacationSituationTypeFormatter(
                    vacationSituationTypeEnum: _getSituationType(),
                    appLocalizations: context.translate,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DocumentItemWidget(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.normal,
                      ),
                      key: const Key('vacation-vacation_schedule_card_card-vacation_type'),
                      title: context.translate.typeVacations,
                      items: [
                        VacationTypeFormatter.getVacationTypeFormatted(
                          appLocalizations: context.translate,
                          vacationTypeEnum: vacationScheduleEntity.vacationType ?? VacationTypeEnum.individual,
                        ),
                      ],
                    ),
                    DocumentItemWidget(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.normal,
                      ),
                      key: const Key('vacation-vacation_schedule_card_card-vacation_start_date'),
                      crossAxisAlignment: _getSecondAlignment(
                        valueToCompare: vacationScheduleEntity.startDate,
                      ),
                      title: context.translate.startDate,
                      items: [
                        DateTimeHelper.formatWithDefaultDatePattern(
                          dateTime: vacationScheduleEntity.startDate!,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DocumentItemWidget(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.normal,
                      ),
                      key: const Key('vacation-vacation_schedule_card_card-vacation_period'),
                      title: context.translate.vacationPeriod,
                      items: [
                        context.translate.balance(
                          vacationScheduleEntity.vacationDays! > 0
                              ? StringHelper.doubleToStringFormatter(
                                  value: vacationScheduleEntity.vacationDays!,
                                )
                              : context.translate.none,
                          vacationScheduleEntity.vacationDays! > 0 ? context.translate.days : '',
                        ),
                      ],
                    ),
                    DocumentItemWidget(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.normal,
                      ),
                      key: const Key('vacation-vacation_schedule_card_card-vacation_allowance'),
                      crossAxisAlignment: _getSecondAlignment(
                        valueToCompare: vacationScheduleEntity.vacationBonusDays,
                      ),
                      title: context.translate.allowance,
                      items: [
                        context.translate.balance(
                          vacationScheduleEntity.vacationBonusDays! > 0
                              ? StringHelper.doubleToStringFormatter(
                                  value: vacationScheduleEntity.vacationBonusDays!,
                                )
                              : context.translate.none,
                          vacationScheduleEntity.vacationBonusDays! > 0 ? context.translate.days : '',
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DocumentItemWidget(
                      padding: const EdgeInsets.only(
                        top: SeniorSpacing.normal,
                      ),
                      key: const Key('vacation-vacation_schedule_card_card-vacation_christmas_bonus_advance'),
                      title: context.translate.christmasBonusAdvance,
                      items: [
                        vacationScheduleEntity.has13thSalaryAdvance! ? context.translate.yes : context.translate.no,
                      ],
                    ),
                  ],
                ),
                (vacationScheduleEntity.commentary != null && showNote)
                    ? DocumentItemWidget(
                        padding: const EdgeInsets.only(
                          top: SeniorSpacing.normal,
                        ),
                        key: const Key('vacation-vacation_schedule_card_card-vacation_'),
                        title: context.translate.note,
                        items: [
                          vacationScheduleEntity.commentary!,
                        ],
                      )
                    : Container(),
                if (hasSignature && canShowSignatureAlert)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SeniorSpacing.normal,
                    ),
                    child: Row(
                      children: [
                        const SeniorIcon(
                          icon: FontAwesomeIcons.solidTriangleExclamation,
                          style: SeniorIconStyle(
                            color: SeniorColors.manchesterColorOrange500,
                          ),
                          size: SeniorIconSize.small,
                        ),
                        Expanded(
                          child: SeniorText.smallBold(
                            ' ${context.translate.pedingDocumentsSignature}',
                            color: SeniorColors.grayscale70,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CrossAxisAlignment _getSecondAlignment({
    dynamic valueToCompare,
  }) {
    return valueToCompare == null ? CrossAxisAlignment.start : CrossAxisAlignment.end;
  }

  Color _getColorBackgroundBadge() {
    switch (_getSituationType()) {
      case VacationSituationTypeEnum.approved:
        return SeniorColors.manchesterColorGreen500;
      case VacationSituationTypeEnum.paid:
        return SeniorColors.manchesterColorBlue500;
      case VacationSituationTypeEnum.waitingApproval:
      case VacationSituationTypeEnum.vacationUpdate:
        return SeniorColors.manchesterColorYellow400;
      case VacationSituationTypeEnum.returnedToAdjustments:
        return SeniorColors.manchesterColorOrange500;
      case VacationSituationTypeEnum.underAnalysis:
        return SeniorColors.supportingColor500;
      case VacationSituationTypeEnum.expired:
        return SeniorColors.manchesterColorRed300;
    }
  }

  Color _getColorFontBadge() {
    VacationSituationTypeEnum situationType = _getSituationType();

    switch (situationType) {
      case VacationSituationTypeEnum.waitingApproval:
      case VacationSituationTypeEnum.returnedToAdjustments:
      case VacationSituationTypeEnum.vacationUpdate:
      case VacationSituationTypeEnum.expired:
        return SeniorColors.neutralColor900;
      default:
        return SeniorColors.neutralColor100;
    }
  }

  IconData _getIconBadge() {
    switch (_getSituationType()) {
      case VacationSituationTypeEnum.approved:
        return FontAwesomeIcons.solidPlane;
      case VacationSituationTypeEnum.paid:
        return FontAwesomeIcons.solidSuitcase;
      case VacationSituationTypeEnum.waitingApproval:
      case VacationSituationTypeEnum.vacationUpdate:
        return FontAwesomeIcons.clock;
      case VacationSituationTypeEnum.returnedToAdjustments:
        return FontAwesomeIcons.solidTriangleExclamation;
      case VacationSituationTypeEnum.underAnalysis:
        return FontAwesomeIcons.solidClock;
      case VacationSituationTypeEnum.expired:
        return FontAwesomeIcons.calendarXmark;
    }
  }

  VacationSituationTypeEnum _getSituationType() {
    return isRequestVacationUpdate && vacationScheduleEntity.situationType! == VacationSituationTypeEnum.approved
        ? VacationSituationTypeEnum.vacationUpdate
        : vacationScheduleEntity.situationType!;
  }
}
