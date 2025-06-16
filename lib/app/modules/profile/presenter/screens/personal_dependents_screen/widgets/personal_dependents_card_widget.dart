import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/cpf_formatter.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/dependent_entity.dart';
import '../../../../enums/personal_request_update_status_enum.dart';
import '../../../../enums/request_type_enum.dart';
import '../../../string_formatters/enum_gender_string_formatter.dart';
import '../../../string_formatters/enum_marital_status_string_formatter.dart';
import '../../../string_formatters/enum_personal_relationship_string_formatter.dart';
import 'dependent_considered_item_widget.dart';
import 'dependent_considered_list_widget.dart';
import 'personal_dependents_line_detail_card.dart';

class PersonalDependentsCardWidget extends StatefulWidget {
  final int index;
  final DependentEntity dependent;
  final bool isAllowedToUpdate;
  final VoidCallback onEditPressed;

  const PersonalDependentsCardWidget({
    Key? key,
    required this.index,
    required this.dependent,
    required this.isAllowedToUpdate,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  State<PersonalDependentsCardWidget> createState() => _PersonalDependentsCardWidgetState();
}

class _PersonalDependentsCardWidgetState extends State<PersonalDependentsCardWidget> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Padding(
      padding: const EdgeInsets.only(
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
        bottom: SeniorSpacing.normal,
      ),
      child: WaapiCardWidget(
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        showActionIcon: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SeniorSpacing.small,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SeniorIcon(
                    icon: FontAwesomeIcons.solidUser,
                    size: SeniorSpacing.medium,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.small,
                  ),
                  Expanded(
                    child: SeniorText.body(
                      widget.dependent.fullName,
                      color: SeniorColors.neutralColor800,
                      darkColor: SeniorColors.pureWhite,
                      textProperties: const TextProperties(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  widget.isAllowedToUpdate
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SeniorSpacing.xsmall,
                          ),
                          child: SeniorIconButton(
                            icon: FontAwesomeIcons.solidPen,
                            onTap: widget.onEditPressed,
                            size: SeniorIconButtonSize.small,
                            type: SeniorIconButtonType.ghost,
                            outlined: false,
                            style: SeniorIconButtonStyle(
                              borderColor: Colors.transparent,
                              iconColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.secondaryColor600,
                              disabledBorderColor: Colors.transparent,
                              disabledIconColor: SeniorColors.neutralColor300,
                              buttonColor: isDarkMode ? Colors.transparent : SeniorColors.pureWhite,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              SizedBox(
                height: widget.isAllowedToUpdate && widget.dependent.requestType == null
                    ? SeniorSpacing.xsmall
                    : SeniorSpacing.normal,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.big,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.dependent.gender != null || widget.dependent.relationshipType != null)
                      PersonalDependentsLineDetailCard(
                        leftTitle: context.translate.gender,
                        leftDetail: widget.dependent.gender != null
                            ? EnumGenderStringFormatter.getEnumGenderTypeString(
                                genderTypeEnum: widget.dependent.gender!,
                                appLocalizations: context.translate,
                              )
                            : null,
                        rightTitle: context.translate.relationshipDegree,
                        rightDetail: widget.dependent.relationshipType != null
                            ? EnumPersonalRelationshipStringFormatter.personalRelationshipEnumToValue(
                                personalRelationshipEnum: widget.dependent.relationshipType!,
                                appLocalizations: context.translate,
                              )
                            : null,
                      ),
                    PersonalDependentsLineDetailCard(
                      leftTitle: context.translate.dateOfBirth,
                      leftDetail: widget.dependent.birthDate != null
                          ? DateTimeHelper.formatWithDefaultDatePattern(
                              dateTime: widget.dependent.birthDate!,
                              locale: LocaleHelper.languageAndCountryCode(
                                locale: Localizations.localeOf(context),
                              ),
                            )
                          : null,
                      rightTitle: context.translate.maritalStatus,
                      rightDetail: widget.dependent.maritalStatus != null
                          ? EnumMaritalStatusStringFormatter.getEnumMaritalStatusTypeString(
                              maritalStatusEnum: widget.dependent.maritalStatus!,
                              appLocalizations: context.translate,
                            )
                          : null,
                    ),
                    PersonalDependentsLineDetailCard(
                      leftTitle: context.translate.cpfNumber,
                      leftDetail: _getCpfNumber(
                        cpfNumber: widget.dependent.cpf!,
                      ),
                      rightTitle: context.translate.rg,
                      rightDetail: (widget.dependent.rg == null || widget.dependent.rg == null)
                          ? ''
                          : widget.dependent.rg!.number,
                    ),
                    DependentConsideredListWidget(
                      isAccountedForIRRF: widget.dependent.isAccountedForIRRF ?? false,
                      isEligibleToAlimony: widget.dependent.isEligibleToAlimony ?? false,
                      isEligibleToFamilyAllowance: widget.dependent.isEligibleToFamilyAllowance ?? false,
                    ),
                    if (widget.dependent.requestType != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SeniorText.small(
                            widget.dependent.requestType == RequestTypeEnum.insert
                                ? context.translate.inclusionStatus
                                : context.translate.editStatus,
                          ),
                          const SizedBox(
                            height: SeniorSpacing.xxsmall,
                          ),
                          Row(
                            children: [
                              DependentConsideredItemWidget(
                                text: getPersonalRequestUpdateStatusEnum(
                                  personalRequestUpdateStatusEnum: widget.dependent.statusUpdate!,
                                ),
                                backgroundColor: getRequestTypeBackgroundColor(
                                  requestType: widget.dependent.requestType!,
                                ),
                                textColor: getRequestTypeTextColor(
                                  requestType: widget.dependent.requestType!,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: SeniorSpacing.xxsmall,
                          ),
                          SeniorText.small(
                            context.translate.requestedOn(
                              DateTimeHelper.formatWithDefaultDateTimePattern(
                                dateTime: widget.dependent.requestUpdateDate!,
                                locale: LocaleHelper.languageAndCountryCode(
                                  locale: Localizations.localeOf(context),
                                ),
                                adjustTimeZone: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getPersonalRequestUpdateStatusEnum({
    required PersonalRequestUpdateStatusEnum personalRequestUpdateStatusEnum,
  }) {
      switch (personalRequestUpdateStatusEnum) {
        case PersonalRequestUpdateStatusEnum.awaitingReview:
          return context.translate.awaitingReview;
        case PersonalRequestUpdateStatusEnum.integrationError:
          return context.translate.integrationError;
        case PersonalRequestUpdateStatusEnum.returnedToAdjustments:
          return context.translate.returnedToAdjustments;
        case PersonalRequestUpdateStatusEnum.waitingIntegration:
          return context.translate.waitingIntegration;
      }
  }

  Color getRequestTypeBackgroundColor({required RequestTypeEnum requestType}) {
    return requestType == RequestTypeEnum.insert
        ? SeniorColors.manchesterColorBlue500
        : SeniorColors.manchesterColorOrange500;
  }

  Color getRequestTypeTextColor({required RequestTypeEnum requestType}) {
    return requestType == RequestTypeEnum.insert ? SeniorColors.pureWhite : SeniorColors.neutralColor900;
  }

  String? _getCpfNumber({String? cpfNumber}) {
    if (cpfNumber != null && cpfNumber.isNotEmpty && cpfNumber != '000.000.000-00') {
      return CPFFormatter.cpfFormatter(
        cpf: cpfNumber,
      );
    }

    return null;
  }
}
