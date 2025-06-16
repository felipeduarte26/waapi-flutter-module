// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import '../../../../enums/cnh_category_enum.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../edit_personal_documents_controllers.dart';
import '../widgets/custom_dropdown_widget.dart';

class EditPersonalDocumentsCnhScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsCnhScreen({
    Key? key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  }) : super(key: key);

  @override
  State<EditPersonalDocumentsCnhScreen> createState() {
    return _EditPersonalDocumentsCnhScreenState();
  }
}

class _EditPersonalDocumentsCnhScreenState extends State<EditPersonalDocumentsCnhScreen> {
  FocusNode cnhNumberFocus = FocusNode();
  FocusNode cnhCategoryFocus = FocusNode();
  FocusNode cnhIssuerFocus = FocusNode();
  FocusNode cnhIssuedDateFocus = FocusNode();
  FocusNode cnhExpiryDateFocus = FocusNode();
  FocusNode cnhFirstIssuedDateFocus = FocusNode();
  FocusNode cnhIssuingStateFocus = FocusNode();

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
                context.translate.cnh,
              ),
            ),
            SeniorTextField(
              maxLength: 20,
              controller: widget.editPersonalDocumentsControllers.cnhNumberController,
              label: context.translate.number,
              focusNode: cnhNumberFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(cnhCategoryFocus);
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              disabled: !(widget.authEntity?.allowToUpdateDocumentCnhNumber ?? true),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              onChanged: (value) {
                setState(
                  () {},
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: CustomDropdownWidget(
                label: context.translate.category,
                disabled: !(widget.authEntity?.allowToUpdateDocumentCnhCategory ?? true),
                key: const Key('profile-edit_personal_cnh_screen-rg_issuing_state_field'),
                value: EnumHelper<CnhCategoryEnum>().stringToEnum(
                  stringToParse: widget.editPersonalDocumentsControllers.cnhCategoryController.text,
                  values: CnhCategoryEnum.values,
                ),
                items: DropdownItemListEnum<CnhCategoryEnum>().dropdownItemList(
                  values: CnhCategoryEnum.values,
                  title: (cnhCategoryEnum) => EnumHelper<CnhCategoryEnum>().enumToString(
                    enumToParse: cnhCategoryEnum,
                  ),
                ),
                onSelected: (value) {
                  widget.editPersonalDocumentsControllers.cnhCategoryController.text =
                      EnumHelper<CnhCategoryEnum>().enumToString(
                    enumToParse: value,
                  );
                  setState(
                    () {},
                  );
                },
                style: const SeniorDropdownButtonStyle(
                  itemListTextColor: SeniorColors.neutralColor900,
                ),
              ),
            ),
            SeniorTextField(
              maxLength: 20,
              disabled: !(widget.authEntity?.allowToUpdateDocumentCnhIssuingBody ?? true),
              controller: widget.editPersonalDocumentsControllers.cnhIssuerController,
              label: context.translate.issuingBody,
              focusNode: cnhIssuerFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(cnhIssuingStateFocus);
              },
              onChanged: (value) {
                setState(
                  () {},
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: CustomDropdownWidget(
                key: const Key('profile-edit_personal_cnh_screen-issuing_state_field'),
                label: context.translate.issuanceBodyFedUnit,
                disabled: !(widget.authEntity?.allowToUpdateDocumentCnhIssuingState ?? true),
                items: DropdownItemListEnum<BrazilianStateEnum>().dropdownItemList(
                  values: BrazilianStateEnum.values,
                  title: (brazilianStateEnum) => EnumHelper<BrazilianStateEnum>().enumToString(
                    enumToParse: brazilianStateEnum,
                  ),
                ),
                value: EnumHelper<BrazilianStateEnum>().stringToEnum(
                  stringToParse: widget.editPersonalDocumentsControllers.cnhIssuerStateController.text,
                  values: BrazilianStateEnum.values,
                ),
                onSelected: (value) {
                  widget.editPersonalDocumentsControllers.cnhIssuerStateController.text =
                      EnumHelper<BrazilianStateEnum>().enumToString(
                    enumToParse: value,
                  );
                  setState(
                    () {},
                  );
                },
                style: const SeniorDropdownButtonStyle(
                  itemListTextColor: SeniorColors.neutralColor900,
                ),
              ),
            ),
            SeniorTextField(
              controller: widget.editPersonalDocumentsControllers.cnhIssuedDateController,
              label: context.translate.issuanceDate,
              disabled: !(widget.authEntity?.allowToUpdateDocumentCnhIssuanceDate ?? true),
              focusNode: cnhIssuedDateFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(cnhFirstIssuedDateFocus);
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                SeniorMaskTextInputHelper(
                  initialText: widget.editPersonalDocumentsControllers.cnhIssuedDateController.text,
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
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              onChanged: (value) {
                setState(
                  () {},
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.xsmall,
              ),
              child: SeniorTextField(
                controller: widget.editPersonalDocumentsControllers.cnhFirstIssuedDateController,
                label: context.translate.dateOfTheFirstDriversLicense,
                disabled: !(widget.authEntity?.allowToUpdateDocumentCnhFirstIssuedDate ?? true),
                focusNode: cnhFirstIssuedDateFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(cnhExpiryDateFocus);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  SeniorMaskTextInputHelper(
                    initialText: widget.editPersonalDocumentsControllers.cnhFirstIssuedDateController.text,
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
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                onChanged: (value) {
                  setState(
                    () {},
                  );
                },
              ),
            ),
            SeniorTextField(
              controller: widget.editPersonalDocumentsControllers.cnhExpiryDateController,
              label: context.translate.expirationDate,
              disabled: !(widget.authEntity?.allowToUpdateDocumentCnhExpiryDate ?? true),
              focusNode: cnhExpiryDateFocus,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                SeniorMaskTextInputHelper(
                  initialText: widget.editPersonalDocumentsControllers.cnhExpiryDateController.text,
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
                }
                return null;
              },
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              onChanged: (value) {
                setState(
                  () {},
                );
              },
            ),
            const SizedBox(
              height: SeniorSpacing.small,
            ),
            SeniorButton(
              outlined: true,
              style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
              disabled: !deleteButtonIsEnable(),
              busy: false,
              fullWidth: true,
              label: context.translate.deleteDocument,
              onPressed: () async {
                confirmDeletionCNH();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> confirmDeletionCNH() async {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deleteTheDriversLicenseInformation,
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
              await widget.editPersonalDocumentsControllers.clearCNH();
              setState(() {});
            },
            danger: true,
          ),
        );
      },
    );
  }

  bool deleteButtonIsEnable() {
    return (widget.editPersonalDocumentsControllers.cnhNumberController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.cnhCategoryController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.cnhIssuerController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.cnhIssuedDateController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.cnhExpiryDateController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.cnhFirstIssuedDateController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.cnhIssuerStateController.text.isNotEmpty);
  }
}
