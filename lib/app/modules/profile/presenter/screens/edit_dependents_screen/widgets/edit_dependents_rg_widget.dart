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
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../../helper/senior_mask_text_input_helper.dart';
import '../../edit_personal_documents_screen/widgets/custom_dropdown_widget.dart';
import '../edit_dependents_controller.dart';

class EditDependentsRgWidget extends StatefulWidget {
  final EditDependentsController editDependentsController;

  const EditDependentsRgWidget({
    Key? key,
    required this.editDependentsController,
  }) : super(key: key);

  @override
  State<EditDependentsRgWidget> createState() {
    return _EditDependentsRgWidgetState();
  }
}

class _EditDependentsRgWidgetState extends State<EditDependentsRgWidget> {
  FocusNode rgNumberFocus = FocusNode();
  FocusNode rgIssuanceDateFocus = FocusNode();
  FocusNode rgIssuerFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SeniorSpacing.small,
          ),
          child: SeniorText.labelBold(
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
            rgIssuanceDateFocus.requestFocus();
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          disabled: false,
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
          ),
          controller: widget.editDependentsController.rgNumberController,
          label: context.translate.number,
        ),
        SeniorTextField(
          onChanged: (value) {
            setState(() {});
          },
          focusNode: rgIssuanceDateFocus,
          onFieldSubmitted: (value) {
            rgIssuerFocus.requestFocus();
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            SeniorMaskTextInputHelper(
              initialText: widget.editDependentsController.rgIssuanceDateController.text,
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
          disabled: false,
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
          ),
          controller: widget.editDependentsController.rgIssuanceDateController,
          label: context.translate.issuanceDate,
        ),
        SeniorTextField(
          focusNode: rgIssuerFocus,
          onChanged: (value) {
            setState(() {});
          },
          maxLength: 20,
          disabled: false,
          controller: widget.editDependentsController.rgIssuerController,
          label: context.translate.issuingBody,
          textInputAction: TextInputAction.done,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SeniorSpacing.xxsmall,
          ),
          child: CustomDropdownWidget(
            key: const Key('edit_dependents_rg_issuing_state'),
            value: EnumHelper().stringToEnum(
              stringToParse: widget.editDependentsController.rgIssuingStateController.text,
              values: BrazilianStateEnum.values,
            ),
            items: DropdownItemListEnum<BrazilianStateEnum>().dropdownItemList(
              values: BrazilianStateEnum.values,
              title: (brazilianStateEnum) => EnumHelper<BrazilianStateEnum>().enumToString(
                enumToParse: brazilianStateEnum,
              ),
            ),
            onSelected: (value) {
              widget.editDependentsController.rgIssuingStateController.text = EnumHelper().enumToString(
                enumToParse: value,
              );
              setState(() {});
            },
            label: context.translate.issuanceBodyFedUnit,
            style: const SeniorDropdownButtonStyle(
              itemListTextColor: SeniorColors.neutralColor900,
            ),
          ),
        ),
      ],
    );
  }
}
