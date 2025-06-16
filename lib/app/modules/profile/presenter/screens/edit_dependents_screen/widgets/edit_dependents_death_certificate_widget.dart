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

class EditDependentsDeathCertificateWidget extends StatefulWidget {
  final EditDependentsController editDependentsController;
  final VoidCallback onValueChanged;

  const EditDependentsDeathCertificateWidget({
    super.key,
    required this.editDependentsController,
    required this.onValueChanged,
  });

  @override
  State<EditDependentsDeathCertificateWidget> createState() => _EditDependentsDeathCertificateWidgetState();
}

class _EditDependentsDeathCertificateWidgetState extends State<EditDependentsDeathCertificateWidget> {
  late EditDependentsScreenBloc editDependentsDataScreenBloc;
  FocusNode deathRegistryNumberFocus = FocusNode();
  FocusNode deathTermNumberFocus = FocusNode();
  FocusNode deathBookNumberFocus = FocusNode();
  FocusNode deathSheetNumberFocus = FocusNode();
  FocusNode deathissuanceDate = FocusNode();
  FocusNode deathNotaryOfficeNameFocus = FocusNode();
  FocusNode deathNotaryOfficeCityFocus = FocusNode();

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
        if (widget.editDependentsController.isEditingDeathOfficeCity) {
          if (state.searchNaturalityState is LoadedSelectNaturalityState &&
              state.searchNaturalityState.selectedNaturalityEntity != null) {
            widget.editDependentsController.deathNotaryOfficeCityController.text =
                state.searchNaturalityState.selectedNaturalityEntity!.name ?? '';
            widget.editDependentsController.deathNotaryOfficeCityIdController.text =
                state.searchNaturalityState.selectedNaturalityEntity!.id ?? '';

            widget.editDependentsController.deathNotaryOfficeCity =
                state.searchNaturalityState.selectedNaturalityEntity;
          }
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: SeniorText.labelBold(
                context.translate.deathCertificate,
              ),
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: deathRegistryNumberFocus,
              onFieldSubmitted: (value) {
                deathRegistryNumberFocus.requestFocus();
              },
              controller: widget.editDependentsController.deathEnrollmentController,
              label: context.translate.registrationNumber,
              maxLength: 40,
              textInputAction: TextInputAction.done,
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: deathTermNumberFocus,
              onFieldSubmitted: (value) {
                deathRegistryNumberFocus.requestFocus();
              },
              controller: widget.editDependentsController.deathTermNumberController,
              label: context.translate.termNumber,
              textInputAction: TextInputAction.done,
              maxLength: 10,
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: deathBookNumberFocus,
              onFieldSubmitted: (value) {
                deathRegistryNumberFocus.requestFocus();
              },
              controller: widget.editDependentsController.deathBookNumberController,
              label: context.translate.bookNumber,
              maxLength: 10,
              textInputAction: TextInputAction.done,
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: deathSheetNumberFocus,
              onFieldSubmitted: (value) {
                deathRegistryNumberFocus.requestFocus();
              },
              controller: widget.editDependentsController.deathSheetNumberController,
              label: context.translate.sheetNumber,
              maxLength: 10,
              textInputAction: TextInputAction.done,
            ),
            SeniorTextField(
              focusNode: deathissuanceDate,
              onFieldSubmitted: (p0) {
                deathNotaryOfficeNameFocus.requestFocus();
              },
              onChanged: (_) {
                widget.onValueChanged();
              },
              controller: widget.editDependentsController.deathIssuanceDateController,
              label: context.translate.issuanceDate,
              style: textFieldStyle,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                SeniorMaskTextInputHelper(
                  initialText: widget.editDependentsController.deathIssuanceDateController.text,
                  mask: '##/##/####',
                ),
              ],
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  const int dayLength = 10;
                  if (value.trim().length < dayLength && !deathissuanceDate.hasFocus) {
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
              focusNode: deathNotaryOfficeNameFocus,
              onFieldSubmitted: (value) {
                deathRegistryNumberFocus.requestFocus();
              },
              controller: widget.editDependentsController.deathNotaryOfficeNameController,
              label: context.translate.notaryOfficeName,
              maxLength: 40,
              textInputAction: TextInputAction.done,
            ),
            SeniorTextField(
              focusNode: deathNotaryOfficeCityFocus,
              onChanged: (_) {
                widget.onValueChanged();
              },
              readOnly: true,
              onTap: () {
                widget.editDependentsController.isEditingDeathOfficeCity = true;
                OptionsSelectBottomSheet.selectNaturality(
                  context: context,
                  searchNaturalityBloc: editDependentsDataScreenBloc.searchNaturalityBloc,
                );
              },
              suffixIcon: FontAwesomeIcons.solidMagnifyingGlass,
              controller: widget.editDependentsController.deathNotaryOfficeCityController,
              label: context.translate.cityOfTheCertificate,
              style: textFieldStyle,
            ),
          ],
        );
      },
    );
  }
}
