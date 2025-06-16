import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../domain/entities/profile_entity.dart';
import '../../../string_formatters/enum_gender_string_formatter.dart';
import '../../../string_formatters/enum_marital_status_string_formatter.dart';

class WaapiPersonDataCardWidget extends StatefulWidget {
  final ProfileEntity profileEntity;
  const WaapiPersonDataCardWidget({Key? key, required this.profileEntity}) : super(key: key);

  @override
  State<WaapiPersonDataCardWidget> createState() {
    return _WaapiPersonDataCardWidgetState();
  }
}

class _WaapiPersonDataCardWidgetState extends State<WaapiPersonDataCardWidget> {
  final EdgeInsets _paddingDocumentItemLeft = const EdgeInsets.only(
    left: SeniorSpacing.big,
    top: SeniorSpacing.normal,
  );
  final EdgeInsets _paddingDocumentItemRight = const EdgeInsets.only(
    top: SeniorSpacing.normal,
  );
  @override
  Widget build(BuildContext context) {
    return WaapiCardWidget(
      showActionIcon: false,
      margin: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SeniorIcon(
                icon: FontAwesomeIcons.solidUser,
                size: SeniorSpacing.medium,
              ),
              const SizedBox(
                width: SeniorSpacing.small,
              ),
              SeniorText.body(
                widget.profileEntity.name,
                color: SeniorColors.neutralColor800,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (widget.profileEntity.personEntity?.birthDate == null && widget.profileEntity.gender == null)
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: widget.profileEntity.personEntity?.birthDate != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        widget.profileEntity.personEntity?.birthDate != null
                            ? DocumentItemWidget(
                                padding: _paddingDocumentItemLeft,
                                title: context.translate.dateOfBirth,
                                items: [
                                  DateTimeHelper.formatWithDefaultDatePattern(
                                    dateTime: widget.profileEntity.personEntity!.birthDate!,
                                    locale: LocaleHelper.languageAndCountryCode(
                                      locale: Localizations.localeOf(context),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        widget.profileEntity.gender != null
                            ? DocumentItemWidget(
                                padding: widget.profileEntity.personEntity?.birthDate != null
                                    ? _paddingDocumentItemRight
                                    : _paddingDocumentItemLeft,
                                crossAxisAlignment: widget.profileEntity.personEntity?.birthDate != null
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                title: context.translate.gender,
                                items: [
                                  EnumGenderStringFormatter.getEnumGenderTypeString(
                                    genderTypeEnum: widget.profileEntity.gender!,
                                    appLocalizations: context.translate,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
              (widget.profileEntity.nationality?.name == null && widget.profileEntity.placeOfBirth?.name == null)
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: widget.profileEntity.nationality?.name != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        widget.profileEntity.nationality?.name != null
                            ? DocumentItemWidget(
                                padding: _paddingDocumentItemLeft,
                                title: context.translate.nationality,
                                items: [
                                  widget.profileEntity.nationality!.name!,
                                ],
                              )
                            : const SizedBox.shrink(),
                        widget.profileEntity.placeOfBirth?.name != null
                            ? DocumentItemWidget(
                                padding: widget.profileEntity.nationality?.name != null
                                    ? _paddingDocumentItemRight
                                    : _paddingDocumentItemLeft,
                                crossAxisAlignment: widget.profileEntity.nationality?.name != null
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                title: context.translate.placeOfBirth,
                                items: [
                                  widget.profileEntity.placeOfBirth!.name!,
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
              (widget.profileEntity.maritalStatus == null && widget.profileEntity.educationDegreeName == null)
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: widget.profileEntity.maritalStatus != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        widget.profileEntity.maritalStatus != null
                            ? DocumentItemWidget(
                                padding: _paddingDocumentItemLeft,
                                title: context.translate.maritalStatus,
                                items: [
                                  EnumMaritalStatusStringFormatter.getEnumMaritalStatusTypeString(
                                    maritalStatusEnum: widget.profileEntity.maritalStatus!,
                                    appLocalizations: context.translate,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        widget.profileEntity.educationDegreeName != null
                            ? DocumentItemWidget(
                                padding: widget.profileEntity.maritalStatus != null
                                    ? _paddingDocumentItemRight
                                    : _paddingDocumentItemLeft,
                                crossAxisAlignment: widget.profileEntity.maritalStatus != null
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                title: context.translate.educationLevel,
                                items: [
                                  widget.profileEntity.educationDegreeName!,
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
              widget.profileEntity.personEntity?.ethnicity?.name == null
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DocumentItemWidget(
                          padding: _paddingDocumentItemLeft,
                          title: context.translate.raceEthnicity,
                          items: [
                            widget.profileEntity.personEntity!.ethnicity!.name!,
                          ],
                        ),
                      ],
                    ),
              widget.profileEntity.disabilities != null
                  ? ListView.separated(
                      addRepaintBoundaries: false,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.profileEntity.disabilities!.length,
                      itemBuilder: (context, index) {
                        return DocumentItemWidget(
                          padding: _paddingDocumentItemLeft,
                          title: context.translate.disability,
                          items: [
                            widget.profileEntity.disabilities![index].disability.name.toString(),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox.shrink();
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
