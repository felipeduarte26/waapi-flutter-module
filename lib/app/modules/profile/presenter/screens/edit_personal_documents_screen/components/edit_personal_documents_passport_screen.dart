import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/enums/brazilian_state_enum.dart';
import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../../../blocs/search_country_bloc/search_country_event.dart';
import '../../../widgets/select_country_bottom_sheet_content_widget.dart';
import '../bloc/edit_personal_documents_screen_bloc.dart';
import '../edit_personal_documents_controllers.dart';
import '../widgets/custom_dropdown_widget.dart';

class EditPersonalDocumentsPassportScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsPassportScreen({
    Key? key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  }) : super(key: key);

  @override
  State<EditPersonalDocumentsPassportScreen> createState() {
    return _EditPersonalDocumentsPassportScreenState();
  }
}

class _EditPersonalDocumentsPassportScreenState extends State<EditPersonalDocumentsPassportScreen> {
  FocusNode passportNumberFocus = FocusNode();
  FocusNode passportCountryFocus = FocusNode();
  FocusNode passportIssuerFocus = FocusNode();
  FocusNode passportStateFocus = FocusNode();
  FocusNode passportIssuedDateFocus = FocusNode();
  FocusNode passportExpiryDateFocus = FocusNode();

  late final EditPersonalDocumentsScreenBloc _editPersonalDocumentsScreenBloc;

  @override
  void initState() {
    super.initState();
    _editPersonalDocumentsScreenBloc = Modular.get<EditPersonalDocumentsScreenBloc>();
  }

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
                context.translate.passport,
              ),
            ),
            SeniorTextField(
              maxLength: 20,
              controller: widget.editPersonalDocumentsControllers.passportNumberController,
              label: context.translate.number,
              focusNode: passportNumberFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(passportCountryFocus);
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              disabled: !(widget.authEntity?.allowToUpdateDocumentPassportNumber ?? true),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              onChanged: (value) {
                setState(
                  () {},
                );
              },
            ),
            const SizedBox(height: SeniorSpacing.xsmall),
            SeniorTextField(
              readOnly: true,
              onTap: () {
                _selectIssuingCountry(context);
              },
              disabled: !(widget.authEntity?.allowToUpdateDocumentPassportCountry ?? true),
              suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
              controller: widget.editPersonalDocumentsControllers.passportCountryController,
              label: context.translate.issuingCountry,
              style: const SeniorTextFieldStyle(
                hintTextColor: SeniorColors.neutralColor900,
                textColor: SeniorColors.neutralColor900,
              ),
            ),
            const SizedBox(height: SeniorSpacing.xsmall),
            SeniorTextField(
              maxLength: 6,
              disabled: !(widget.authEntity?.allowToUpdateDocumentPassportIssuingBody ?? true),
              controller: widget.editPersonalDocumentsControllers.passportIssuerController,
              label: context.translate.issuingBody,
              focusNode: passportIssuerFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(passportIssuerFocus);
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
                key: const Key('profile-edit_personal_passport_screen-issuing_state_field'),
                label: context.translate.issuanceBodyFedUnit,
                items: DropdownItemListEnum<BrazilianStateEnum>().dropdownItemList(
                  values: BrazilianStateEnum.values,
                  title: (brazilianStateEnum) => EnumHelper<BrazilianStateEnum>().enumToString(
                    enumToParse: brazilianStateEnum,
                  ),
                ),
                value: EnumHelper<BrazilianStateEnum>().stringToEnum(
                  stringToParse: widget.editPersonalDocumentsControllers.passportIssuerStateController.text,
                  values: BrazilianStateEnum.values,
                ),
                onSelected: (value) {
                  widget.editPersonalDocumentsControllers.passportIssuerStateController.text =
                      EnumHelper<BrazilianStateEnum>().enumToString(
                    enumToParse: value,
                  );
                  setState(
                    () {},
                  );
                },
                disabled: !(widget.authEntity?.allowToUpdateDocumentPassportState ?? true),
                style: const SeniorDropdownButtonStyle(
                  itemListTextColor: SeniorColors.neutralColor900,
                ),
              ),
            ),
            SeniorTextField(
              controller: widget.editPersonalDocumentsControllers.passportIssuedDateController,
              label: context.translate.issuanceDate,
              disabled: !(widget.authEntity?.allowToUpdateDocumentPassportIssuanceDate ?? true),
              focusNode: passportIssuedDateFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(passportExpiryDateFocus);
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                SeniorMaskTextInputHelper(
                  initialText: widget.editPersonalDocumentsControllers.passportIssuedDateController.text,
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
                controller: widget.editPersonalDocumentsControllers.passportExpiryDateController,
                label: context.translate.expirationDate,
                disabled: !(widget.authEntity?.allowToUpdateDocumentPassportExpiryDate ?? true),
                focusNode: passportExpiryDateFocus,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  SeniorMaskTextInputHelper(
                    initialText: widget.editPersonalDocumentsControllers.passportExpiryDateController.text,
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
            ),
            SeniorButton(
              outlined: true,
              style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
              disabled: !deleteButtonIsEnable(),
              busy: false,
              fullWidth: true,
              label: context.translate.deleteDocument,
              onPressed: () async {
                confirmDeletionPassport();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectIssuingCountry(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.defineIssuingCountry,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: SelectCountryBottomSheetContentWidget(
            key: const Key('profile-input_personal_screen-select_nationality_bottom_sheet_content_widget'),
            searchCountryBloc: _editPersonalDocumentsScreenBloc.searchCountryBloc,
            initialTitle: context.translate.countrySearchHelp,
            initialSubtitle: context.translate.countrySearchHelpDescription,
            noFoundTitle: context.translate.countryNoDataFound,
            noFoundSubtitle: context.translate.countryNoDataFoundDescription,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        _editPersonalDocumentsScreenBloc.searchCountryBloc.add(ClearSearchCountryProfileEvent());
        Modular.to.pop();
      },
    );
  }

  Future<void> confirmDeletionPassport() async {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deletePassportInformation,
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
              await widget.editPersonalDocumentsControllers.clearPassport();
              setState(() {});
            },
            danger: true,
          ),
        );
      },
    );
  }

  bool deleteButtonIsEnable() {
    return (widget.editPersonalDocumentsControllers.passportNumberController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.passportCountryController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.passportIssuerController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.passportIssuedDateController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.passportExpiryDateController.text.isNotEmpty ||
        widget.editPersonalDocumentsControllers.passportIssuerStateController.text.isNotEmpty);
  }
}
