import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../helper/nis_validator_helper.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../edit_personal_documents_controllers.dart';

class EditPersonalDocumentsNisScreen extends StatefulWidget {
  final EditPersonalDocumentsControllers editPersonalDocumentsControllers;
  final AuthorizationEntity? authEntity;

  const EditPersonalDocumentsNisScreen({
    super.key,
    required this.editPersonalDocumentsControllers,
    required this.authEntity,
  });

  @override
  State<EditPersonalDocumentsNisScreen> createState() {
    return _EditPersonalDocumentsNisScreenState();
  }
}

class _EditPersonalDocumentsNisScreenState extends State<EditPersonalDocumentsNisScreen> {
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
            SeniorText.h4(
              context.translate.nis,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
                top: SeniorSpacing.normal,
              ),
              child: SeniorText.body(
                '* ${context.translate.mandatoryItem}',
                color: SeniorColors.neutralColor600,
              ),
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              disabled: !(widget.authEntity?.allowToUpdateDocumentNisNumber ?? true),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                SeniorMaskTextInputHelper(
                  initialText: widget.editPersonalDocumentsControllers.nisNumberController.text,
                  mask: '###.#####.##-#',
                  filter: {'#': RegExp(r'[0-9]')},
                  type: SeniorMaskAutoCompletionType.lazy,
                ),
              ],
              controller: widget.editPersonalDocumentsControllers.nisNumberController,
              label: '${context.translate.number} *',
              validator: (value) {
                if (value != null && value.length == 14) {
                  if (NisValidatorHelper.isValid(value)) {
                    return null;
                  }
                }
                return context.translate.nisNumberInvalid;
              },
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
            SeniorTextField(
              onChanged: (value) {
                setState(() {});
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                SeniorMaskTextInputHelper(
                  initialText: widget.editPersonalDocumentsControllers.nisRegisterDateController.text,
                  mask: '##/##/####',
                ),
              ],
              disabled: !(widget.authEntity?.allowToUpdateDocumentNisRegistrationDate ?? true),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              controller: widget.editPersonalDocumentsControllers.nisRegisterDateController,
              label: context.translate.issuanceDate,
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
            ),
          ],
        ),
      ),
    );
  }
}
