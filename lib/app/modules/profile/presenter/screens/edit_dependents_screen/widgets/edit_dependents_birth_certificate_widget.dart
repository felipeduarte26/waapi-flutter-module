import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../helper/options_select_bottom_sheet.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';
import '../bloc/edit_dependents_screen_bloc.dart';
import '../bloc/edit_dependents_screen_state.dart';
import '../edit_dependents_controller.dart';

class EditDependentsBirthCertificateWidget extends StatefulWidget {
  final EditDependentsController editDependentsController;
  final VoidCallback onValueChanged;

  const EditDependentsBirthCertificateWidget({
    super.key,
    required this.editDependentsController,
    required this.onValueChanged,
  });

  @override
  State<EditDependentsBirthCertificateWidget> createState() => _EditDependentsBirthCertificateWidgetState();
}

class _EditDependentsBirthCertificateWidgetState extends State<EditDependentsBirthCertificateWidget> {
  late EditDependentsScreenBloc editDependentsDataScreenBloc;
  FocusNode birthRegistryNumberFocus = FocusNode();
  FocusNode birthTermNumberFocus = FocusNode();
  FocusNode birthBookNumberFocus = FocusNode();
  FocusNode birthSheetNumberFocus = FocusNode();
  FocusNode issuanceDate = FocusNode();
  FocusNode birthNotaryOfficeNameFocus = FocusNode();
  FocusNode birthNotaryOfficeCityFocus = FocusNode();

  @override
  void initState() {
    editDependentsDataScreenBloc = Modular.get<EditDependentsScreenBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final textFieldStyle = themeRepository.isCustomTheme() ? null : WaapiStyleTheme.waapiSeniorTextFieldStyle();

    return BlocConsumer<EditDependentsScreenBloc, EditDependentsScreenState>(
      bloc: editDependentsDataScreenBloc,
      listener: (context, state) {
        if (!widget.editDependentsController.isEditingDeathOfficeCity) {
          if (state.searchNaturalityState is LoadedSelectNaturalityState &&
              state.searchNaturalityState.selectedNaturalityEntity != null) {
            widget.editDependentsController.birthNotaryOfficeCityController.text =
                state.searchNaturalityState.selectedNaturalityEntity!.name ?? '';
            widget.editDependentsController.birthNotaryOfficeCityIdController.text =
                state.searchNaturalityState.selectedNaturalityEntity!.id ?? '';

            widget.editDependentsController.birthNotaryOfficeCity =
                state.searchNaturalityState.selectedNaturalityEntity;
          }
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorText.h4(
                context.translate.additionalDocuments,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorText.body(
                '* ${context.translate.optional}',
                color: SeniorColors.neutralColor600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorText.labelBold(
                context.translate.birthCertificate,
              ),
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: birthRegistryNumberFocus,
              onFieldSubmitted: (value) {
                birthRegistryNumberFocus.requestFocus();
              },
              disabled: false,
              controller: widget.editDependentsController.birthEnrollmentController,
              label: context.translate.registrationNumber,
              maxLength: 40,
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: birthTermNumberFocus,
              onFieldSubmitted: (value) {
                birthRegistryNumberFocus.requestFocus();
              },
              disabled: false,
              controller: widget.editDependentsController.birthTermNumberController,
              label: context.translate.termNumber,
              maxLength: 10,
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: birthBookNumberFocus,
              onFieldSubmitted: (value) {
                birthRegistryNumberFocus.requestFocus();
              },
              disabled: false,
              controller: widget.editDependentsController.birthBookNumberController,
              label: context.translate.bookNumber,
              maxLength: 10,
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: birthSheetNumberFocus,
              onFieldSubmitted: (value) {
                birthRegistryNumberFocus.requestFocus();
              },
              disabled: false,
              controller: widget.editDependentsController.birthSheetNumberController,
              label: context.translate.sheetNumber,
              maxLength: 10,
            ),
            SeniorTextField(
              focusNode: issuanceDate,
              onFieldSubmitted: (_) {
                birthNotaryOfficeNameFocus.requestFocus();
              },
              onChanged: (_) {
                widget.onValueChanged();
              },
              disabled: false,
              controller: widget.editDependentsController.birthIssuanceDateController,
              label: context.translate.issuanceDate,
              style: textFieldStyle,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                SeniorMaskTextInputHelper(
                  initialText: widget.editDependentsController.birthIssuanceDateController.text,
                  mask: '##/##/####',
                ),
              ],
              validator: (value) {
                const int dayLength = 10;
                if (value != null && value.isNotEmpty) {
                  if (value.trim().length < dayLength && !issuanceDate.hasFocus) {
                    return context.translate.wrongAlert;
                  }

                  if (!DateTimeHelper.validateDate(
                        date: value,
                        locale: LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ) &&
                      value.trim().length == dayLength) {
                    return context.translate.invalidDate;
                  }

                  if (!DateTimeHelper.validateDate(
                        date: value,
                        locale: LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                        validateCurrentMajorYear: true,
                      ) &&
                      value.trim().length == dayLength) {
                    return context.translate.theDateReportedMustBeEarlierthanToday;
                  }
                }
                return null;
              },
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: birthNotaryOfficeNameFocus,
              onFieldSubmitted: (value) {
                birthRegistryNumberFocus.requestFocus();
              },
              disabled: false,
              controller: widget.editDependentsController.birthNotaryOfficeNameController,
              label: context.translate.notaryOfficeName,
              maxLength: 40,
            ),
            SeniorTextField(
              focusNode: birthNotaryOfficeCityFocus,
              onChanged: (_) {
                widget.onValueChanged();
              },
              readOnly: true,
              onTap: () {
                widget.editDependentsController.isEditingDeathOfficeCity = false;
                OptionsSelectBottomSheet.selectNaturality(
                  context: context,
                  searchNaturalityBloc: editDependentsDataScreenBloc.searchNaturalityBloc,
                );
              },
              disabled: false,
              suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
              controller: widget.editDependentsController.birthNotaryOfficeCityController,
              label: context.translate.cityOfTheCertificate,
              style: textFieldStyle,
            ),
          ],
        );
      },
    );
  }
}
