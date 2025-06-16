import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/enums/brazilian_state_enum.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../edit_personal_documents_controllers.dart';
import '../widgets/custom_dropdown_widget.dart';

class EditPersonalDocumentsCtpsScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsCtpsScreen({
    Key? key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  }) : super(key: key);

  @override
  State<EditPersonalDocumentsCtpsScreen> createState() {
    return _EditPersonalDocumentsCtpsScreenState();
  }
}

class _EditPersonalDocumentsCtpsScreenState extends State<EditPersonalDocumentsCtpsScreen> {
  FocusNode ctpsNumberFocus = FocusNode();
  FocusNode ctpsSerieFocus = FocusNode();
  FocusNode ctpsSerieDigitFocus = FocusNode();
  FocusNode ctpsIssuanceDateFocus = FocusNode();
  FocusNode ctpsIssuingStateFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.small,
              ),
              child: SeniorText.h4(
                context.translate.ctps,
              ),
            ),
            SeniorTextField(
              focusNode: ctpsNumberFocus,
              controller: widget.editPersonalDocumentsControllers.ctpsNumberController,
              maxLength: 9,
              disabled: !(widget.authEntity?.allowToUpdateDocumentCtpsNumber ?? true),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              label: context.translate.number,
              onChanged: (value) {
                setState(
                  () {},
                );
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(
                  ctpsSerieFocus,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.xsmall,
              ),
              child: SeniorTextField(
                focusNode: ctpsSerieFocus,
                maxLength: 5,
                disabled: !(widget.authEntity?.allowToUpdateDocumentCtpsSerie ?? true),
                controller: widget.editPersonalDocumentsControllers.ctpsSerieController,
                label: context.translate.series,
                onChanged: (value) {
                  setState(
                    () {},
                  );
                },
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(
                    ctpsSerieDigitFocus,
                  );
                },
              ),
            ),
            SeniorTextField(
              focusNode: ctpsSerieDigitFocus,
              maxLength: 2,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(
                  ctpsIssuingStateFocus,
                );
              },
              onChanged: (value) {
                setState(
                  () {},
                );
              },
              disabled: !(widget.authEntity?.allowToUpdateDocumentCtpsDigit ?? true),
              controller: widget.editPersonalDocumentsControllers.ctpsSerieDigitController,
              label: context.translate.digit,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.xsmall,
                bottom: SeniorSpacing.small,
              ),
              child: SeniorTextField(
                onChanged: (value) {
                  setState(
                    () {},
                  );
                },
                focusNode: ctpsIssuingStateFocus,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  SeniorMaskTextInputHelper(
                    initialText: widget.editPersonalDocumentsControllers.ctpsIssuanceDateController.text,
                    mask: '##/##/####',
                  ),
                ],
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!DateTimeHelper.validateDate(
                      date: value,
                      locale: LocaleHelper.languageAndCountryCode(
                        locale: Localizations.localeOf(context),
                      ),
                    )) {
                      return context.translate.invalidDate;
                    }
                    if (!DateTimeHelper.validateDate(
                      date: value,
                      locale: LocaleHelper.languageAndCountryCode(
                        locale: Localizations.localeOf(context),
                      ),
                      validateCurrentMajorYear: true,
                    )) {
                      return context.translate.theDateReportedMustBeEarlierthanToday;
                    }
                  }

                  return null;
                },
                disabled: !(widget.authEntity?.allowToUpdateDocumentCtpsIssuedDate ?? true),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                controller: widget.editPersonalDocumentsControllers.ctpsIssuanceDateController,
                label: context.translate.issuanceDate,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: CustomDropdownWidget(
                key: const Key('profile-edit_personal_address-patioType-loading-false'),
                value: EnumHelper<BrazilianStateEnum>().stringToEnum(
                  stringToParse: widget.editPersonalDocumentsControllers.ctpsIssuingStateController.text,
                  values: BrazilianStateEnum.values,
                ),
                items: DropdownItemListEnum<BrazilianStateEnum>().dropdownItemList(
                  values: BrazilianStateEnum.values,
                  title: (brazilianStateEnum) => EnumHelper<BrazilianStateEnum>().enumToString(
                    enumToParse: brazilianStateEnum,
                  ),
                ),
                disabled: !(widget.authEntity?.allowToUpdateDocumentCtpsState ?? true),
                onSelected: (value) {
                  widget.editPersonalDocumentsControllers.ctpsIssuingStateController.text = EnumHelper().enumToString(
                    enumToParse: value,
                  );
                  setState(
                    () {},
                  );
                },
                label: context.translate.addressState,
                style: const SeniorDropdownButtonStyle(
                  itemListTextColor: SeniorColors.neutralColor900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
