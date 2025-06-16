import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/enums/brazilian_state_enum.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../edit_personal_documents_controllers.dart';
import '../widgets/custom_dropdown_widget.dart';

class EditPersonalDocumentsRgScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsRgScreen({
    Key? key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  }) : super(key: key);

  @override
  State<EditPersonalDocumentsRgScreen> createState() {
    return _EditPersonalDocumentsRgScreenState();
  }
}

class _EditPersonalDocumentsRgScreenState extends State<EditPersonalDocumentsRgScreen> {
  FocusNode rgNumberFocus = FocusNode();
  FocusNode rgIssuanceDateFocus = FocusNode();
  FocusNode rgIssuerFocus = FocusNode();

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
                context.translate.rg,
              ),
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: rgNumberFocus,
              maxLength: 15,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(rgIssuanceDateFocus);
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              disabled: !(widget.authEntity?.allowToUpdateDocumentRgIssuanceDate ?? true),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              controller: widget.editPersonalDocumentsControllers.rgNumberController,
              label: context.translate.number,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.xsmall,
              ),
              child: SeniorTextField(
                onChanged: (value) {
                  setState(() {});
                },
                focusNode: rgIssuanceDateFocus,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(rgIssuerFocus);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  SeniorMaskTextInputHelper(
                    initialText: widget.editPersonalDocumentsControllers.rgIssuanceDateController.text,
                    mask: '##/##/####',
                    filter: {'#': RegExp(r'[0-9]')},
                    type: SeniorMaskAutoCompletionType.eager,
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
                disabled: !(widget.authEntity?.allowToUpdateDocumentRgIssuanceDate ?? true),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                controller: widget.editPersonalDocumentsControllers.rgIssuanceDateController,
                label: context.translate.issuanceDate,
              ),
            ),
            SeniorTextField(
              focusNode: rgIssuerFocus,
              onChanged: (value) {
                setState(() {});
              },
              maxLength: 15,
              disabled: !(widget.authEntity?.allowToUpdateDocumentRgIssuingBody ?? true),
              controller: widget.editPersonalDocumentsControllers.rgIssuerController,
              label: context.translate.issuingBody,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: SeniorSpacing.small,
                bottom: SeniorSpacing.normal,
              ),
              child: CustomDropdownWidget(
                key: const Key('profile-edit_personal_address-patioType-loading-false'),
                value: EnumHelper().stringToEnum(
                  stringToParse: widget.editPersonalDocumentsControllers.rgIssuingStateController.text,
                  values: BrazilianStateEnum.values,
                ),
                items: DropdownItemListEnum<BrazilianStateEnum>().dropdownItemList(
                  values: BrazilianStateEnum.values,
                  title: (brazilianStateEnum) => EnumHelper<BrazilianStateEnum>().enumToString(
                    enumToParse: brazilianStateEnum,
                  ),
                ),
                onSelected: (value) {
                  widget.editPersonalDocumentsControllers.rgIssuingStateController.text = EnumHelper().enumToString(
                    enumToParse: value,
                  );
                  setState(() {});
                },
                label: context.translate.issuanceBodyFedUnit,
                disabled: !(widget.authEntity?.allowToUpdateDocumentRgIssuingState ?? true),
                style: const SeniorDropdownButtonStyle(
                  itemListTextColor: SeniorColors.neutralColor900,
                ),
              ),
            ),
            SeniorButton(
              outlined: true,
              style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
              disabled: deleteButtonIsEnable(),
              busy: false,
              fullWidth: true,
              label: context.translate.deleteDocument,
              onPressed: () async {
                await confirmDeletionRG();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> confirmDeletionRG() async {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deleteRg,
          content: context.translate.deleteMessageDocument,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () {
              Modular.to.pop();
            },
          ),
          otherAction: SeniorModalAction(
            label: context.translate.erase,
            action: () async {
              Modular.to.pop();
              await widget.editPersonalDocumentsControllers.clearRG();
              setState(() {});
            },
            danger: true,
          ),
        );
      },
    );
  }

  bool deleteButtonIsEnable() {
    return widget.editPersonalDocumentsControllers.rgNumberController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.rgIssuanceDateController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.rgIssuerController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.rgIssuingStateController.text.isEmpty;
  }
}
