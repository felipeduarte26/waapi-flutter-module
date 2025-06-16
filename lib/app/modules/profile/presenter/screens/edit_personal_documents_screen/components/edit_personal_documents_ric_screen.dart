import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../../../blocs/search_naturality/search_naturality_event.dart';
import '../../../widgets/select_naturality_bottom_sheet_content_widget.dart';
import '../bloc/edit_personal_documents_screen_bloc.dart';
import '../edit_personal_documents_controllers.dart';

class EditPersonalDocumentsRicScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsRicScreen({
    Key? key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  }) : super(key: key);

  @override
  State<EditPersonalDocumentsRicScreen> createState() {
    return _EditPersonalDocumentsRicScreenState();
  }
}

class _EditPersonalDocumentsRicScreenState extends State<EditPersonalDocumentsRicScreen> {
  FocusNode ricNumberFocus = FocusNode();
  FocusNode ricIssuanceDat = FocusNode();
  FocusNode ricIssuer = FocusNode();
  FocusNode ricIssuingCityController = FocusNode();

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
                context.translate.ric,
              ),
            ),
            SeniorTextField(
              maxLength: 14,
              controller: widget.editPersonalDocumentsControllers.ricNumberController,
              label: context.translate.number,
              focusNode: ricNumberFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(ricIssuanceDat);
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              disabled: !(widget.authEntity?.allowToUpdateDocumentRicNumber ?? true),
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
                onChanged: (value) {
                  setState(
                    () {},
                  );
                },
                focusNode: ricIssuanceDat,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  SeniorMaskTextInputHelper(
                    initialText: widget.editPersonalDocumentsControllers.ricIssuanceDateController.text,
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
                disabled: !(widget.authEntity?.allowToUpdateDocumentRicIssuanceDate ?? true),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                controller: widget.editPersonalDocumentsControllers.ricIssuanceDateController,
                label: context.translate.issuanceDate,
              ),
            ),
            SeniorTextField(
              maxLength: 20,
              disabled: !(widget.authEntity?.allowToUpdateDocumentRicIssuingBody ?? true),
              controller: widget.editPersonalDocumentsControllers.cnhIssuerController,
              label: context.translate.issuingBody,
              focusNode: ricIssuer,
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
                readOnly: true,
                onTap: () {
                  _selectNaturality(context);
                },
                disabled: !(widget.authEntity?.allowToUpdateDocumentRicIssuingCity ?? true),
                suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
                controller: widget.editPersonalDocumentsControllers.ricIssuingCityController,
                label: context.translate.issuingCity,
                style: const SeniorTextFieldStyle(
                  hintTextColor: SeniorColors.neutralColor900,
                  textColor: SeniorColors.neutralColor900,
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
                await confirmDeletionRIC();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectNaturality(BuildContext context) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.naturalityTitle,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: SelectNaturalityBottomSheetContentWidget(
            key: const Key('profile-input_personal_screen-select_naturality_bottom_sheet_content_widget'),
            searchNaturalityBloc: _editPersonalDocumentsScreenBloc.searchRicCityBloc,
            initialTitle: context.translate.naturalitySearchHelp,
            initialSubtitle: context.translate.naturalitySearchHelpDescription,
            noFoundTitle: context.translate.naturalityNoDataFound,
            noFoundSubtitle: context.translate.naturalityNoDataFoundDescription,
            textFieldLabel: context.translate.naturality,
            isNaturality: true,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        _editPersonalDocumentsScreenBloc.searchRicCityBloc.add(ClearSearchNaturalityProfileEvent());
        Modular.to.pop();
      },
    );
  }

  Future<void> confirmDeletionRIC() async {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.deleteRic,
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
              await widget.editPersonalDocumentsControllers.clearRIC();
              setState(() {});
            },
            danger: true,
          ),
        );
      },
    );
  }

  bool deleteButtonIsEnable() {
    return widget.editPersonalDocumentsControllers.ricNumberController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.ricIssuanceDateController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.ricIssuerController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.ricIssuingCityIdController.text.isEmpty &&
        widget.editPersonalDocumentsControllers.ricIssuingCityController.text.isEmpty;
  }
}
